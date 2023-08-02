module main

import rand
import json
import time
import net.http
import vweb

struct VerificationCode {
	code      string
	timestamp time.Time
}

struct LoginRequest {
	email string
}

struct VerificationData {
	email string
	code  string
}

struct Admin {
	email string
	code  string
}

struct User {
	id        int       [primary; sql: serial]
	email     string    [primary; unique]
	code      string
	timestamp time.Time [sql_type: 'DATETIME']
}

struct EmailData {
	from          string
	to            string
	subject       string
	htmlbody      string
	textbody      string
	messagestream string
}

['/login'; post]
fn (mut app App) login() !vweb.Result {
	login_data := json.decode(LoginRequest, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, 'failed to decode login data'}
		return app.json(er)
	}
	code := rand.hex(20)
	user := User{
		email: login_data.email
		code: code
		timestamp: time.now()
	}
	resp := app.send_verification_email(user) or {
		app.set_status(500, 'Server Error')
		er := CustomResponse{500, 'failed to send verification email ${err}'}

		return app.json(er)
	}
	if resp.status_code != 200 {
		app.set_status(resp.status_code, 'Failed to send email')
		er := CustomResponse{resp.status_code, 'failed to send verification email'}
		return app.json(er)
	}

	// save user to database
	users := sql app.db {
		select from User where email == user.email
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	// delete old entry
	if users.len > 0 {
		sql app.db {
			delete from User where email == user.email
		} or {
			app.set_status(500, 'Failed to Delete user')
			return app.text('${err}')
		}
	}
	sql app.db {
		insert user into User
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}

	app.set_status(200, 'Successfully Logged in')
	return app.json(login_data)
}

fn (mut app App) send_verification_email(user User) !http.Response {
	email_data := EmailData{
		from: app.sender_email
		to: user.email
		subject: 'Verification Email'
		htmlbody: '<b>Hello</b> <p> please use this verification code: <b>${user.code}</b> to verify email</p>'
		textbody: 'Hello, please use this verification code: ${user.code} to verify email'
		messagestream: 'outbound'
	}
	headers := http.new_custom_header_from_map({
		'Accept':                  'application/json'
		'Content-Type':            'application/json'
		'X-Postmark-Server-Token': '${app.postmark_token}'
	})!
	req := http.Request{
		method: http.Method.post
		header: headers
		url: 'https://api.postmarkapp.com/email'
		data: json.encode(email_data)
	}
	return req.do()!
}

['/verify'; post]
fn (mut app App) check_verification_code() vweb.Result {
	verification_req := json.decode(VerificationData, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, 'failed to decode verification data'}
		return app.json(er)
	}
	users := sql app.db {
		select from User where email == verification_req.email && code == verification_req.code
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	if users.len < 1 {
		app.set_status(404, 'Not Found')
		er := CustomResponse{404, 'user not found'}
		return app.json(er)
	}
	app.set_status(200, 'OK')
	return app.json({
		'status': 'ok'
	})
}

['/admin/login'; post]
fn (mut app App) login_admin() !vweb.Result {
	admin := json.decode(Admin, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, 'failed to decode admin data'}
		return app.json(er)
	}
	if admin.email != app.admin_email || admin.code != app.admin_password {
		app.set_status(401, 'Invalid credentials')
		er := CustomResponse{401, 'Invalid credentials'}
		return app.json(er)
	}

	app.set_status(200, 'Successfully Logged in')
	return app.json('{}')
}
