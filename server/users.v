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
		return app.json(er.to_json())
	}

	resp := app.send_verification_email(login_data.email) or {
		app.set_status(500, 'Server Error')
		er := CustomResponse{500, 'failed to send verification email'}
		return app.json(er.to_json())
	}
	if resp.status_code != 200 {
		app.set_status(resp.status_code, 'Failed to send email')
		er := CustomResponse{resp.status_code, 'failed to send verification email'}
		return app.json(er.to_json())
	}

	app.set_status(200, 'Successfully Logged in')
	return app.json(json.encode(login_data))
}

fn (mut app App) send_verification_email(email string) !http.Response {
	code := rand.hex(20)
	verification_codes[email] = VerificationCode{
		code: code
		timestamp: time.now()
	}
	email_data := EmailData{
		from: 'foudaa@incubaid.com'
		to: email
		subject: 'Verification Email'
		htmlbody: '<b>Hello</b> <p> please use this verification code: <b>${code}</b> to verify email</p>'
		textbody: 'Hello, please use this verification code: ${code} to verify email'
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
		return app.json(er.to_json())
	}
	saved_req := verification_codes[verification_req.email] or {
		app.set_status(404, 'Email Not Found')
		er := CustomResponse{404, 'verification code is not correct'}
		return app.json(er.to_json())
	}
	if verification_req.code != saved_req.code {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, "either email doesn't exist or verification code is wrong"}
		return app.json(er.to_json())
	}
	app.set_status(200, 'OK')
	return app.json(json.encode({
		'status': 'ok'
	}))
}

['/admin/login'; post]
fn (mut app App) login_admin() !vweb.Result {
	admin := json.decode(Admin, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, 'failed to decode admin data'}
		return app.json(er.to_json())
	}
	if admin.email != app.admin_email || admin.code != app.admin_password {
		app.set_status(401, 'Invalid credentials')
		er := CustomResponse{401, 'Invalid credentials'}
		return app.json(er.to_json())
	}

	app.set_status(200, 'Successfully Logged in')
	return app.json('{}')
}
