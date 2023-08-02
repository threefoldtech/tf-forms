module main

import vweb
import time
import json
import os
import flag
import net.http
import db.sqlite

pub struct App {
	vweb.Context
pub mut:
	db             sqlite.DB
	postmark_token string    [vweb_global]
	admin_email    string    [vweb_global]
	admin_password string    [vweb_global]
	sender_email   string    [vweb_global]
}

pub fn (mut app App) before_request() {
	app.add_header('Access-Control-Allow-Origin', '*')
	app.add_header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
	app.add_header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, hx-request, hx-current-url')
	if app.req.method == http.Method.options {
		app.ok('ok')
	}
}

pub fn (mut app App) check_auth() bool {
	mut email := ''
	mut code := ''
	if app.req.method == http.Method.get {
		email = app.query['email'] or { return false }
		code = app.query['code'] or { return false }
	} else {
		data := json.decode(VerificationData, app.req.data) or {
			app.set_status(400, 'Bad Request')
			return false
		}
		email = data.email
		code = data.code
	}
	users := sql app.db {
		select from User where email == email && code == code
	} or {
		app.set_status(401, 'Unauthorized')
		return false
	}
	// delete old entry
	if users.len < 1 {
		app.set_status(401, 'Unauthorized')
		return false
	}
	duration := time.now() - users[0].timestamp
	if duration.hours() > 24 * 7 {
		app.set_status(400, 'Expired Code')
		return false
	}
	return true
}

pub fn (mut app App) check_admin() bool {
	email := app.query['email'] or {
		app.set_status(400, 'Bad Request')
		return false
	}
	code := app.query['code'] or {
		app.set_status(400, 'Bad Request')
		return false
	}
	if email == app.admin_email && code == app.admin_password {
		return true
	}
	app.set_status(401, 'Unauthorized')
	return false
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('threefold forms')
	fp.version('v0.0.1')
	fp.skip_executable()
	postmark_token := fp.string('token', `t`, '', 'Postmark API token')
	admin_email := fp.string('admin_email', `e`, '', 'Admin Email')
	admin_password := fp.string('admin_password', `p`, '', 'Admin password')
	sender_email := fp.string('sender_email', `s`, '', 'Sender Email')

	mut db := sqlite.connect('forms.db')!
	sql db {
		create table Contact
	}!
	sql db {
		create table Interests
	}!
	sql db {
		create table Presale
	}!
	sql db {
		create table Order
	}!
	sql db {
		create table Investment
	}!
	sql db {
		create table User
	}!

	mut app := &App{
		db: db
		postmark_token: postmark_token
		admin_email: admin_email
		admin_password: admin_password
		sender_email: sender_email
	}
	vweb.run(app, 8080)
}
