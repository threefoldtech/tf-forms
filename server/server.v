module main

import vweb
import time
import json
import os
import flag
import net.http

__global (
	contacts           map[string]Contact
	investments        map[string]Investment
	presales           map[string]Presale
	verification_codes map[string]VerificationCode
)
pub struct App {
	vweb.Context
pub mut:
	postmark_token     string                      [vweb_global]
	contacts           map[string]Contact          [vweb_global]
	investments        map[string]Investment       [vweb_global]
	presales           map[string]Presale          [vweb_global]
	verification_codes map[string]VerificationCode [vweb_global]
	admin_email        string                      [vweb_global]
	admin_password     string                      [vweb_global]
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
		data := json.decode(VerificationData, app.req.data) or { return false }
		email = data.email
		code = data.code
	}
	saved_code := app.verification_codes[email] or { return false }
	if code != saved_code.code {
		return false
	}
	duration := time.now() - saved_code.timestamp
	if duration.hours() > 24 * 7 {
		return false
	}
	return true
}

pub fn (mut app App) check_admin() bool {
	email := app.query['email'] or { return false }
	code := app.query['code'] or { return false }
	if email == app.admin_email && code == app.admin_password {
		return true
	}
	return false
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('threefold forms')
	fp.version('v0.0.1')
	fp.skip_executable()
	postmark_token := fp.string('token', `t`, '', 'Postmark API token')
	admin_email := fp.string('admin_email', `e`, '', 'Postmark API token')
	admin_password := fp.string('admin_password', `p`, '', 'Postmark API token')
	mut app := &App{
		// postmark_token: 'fd590f17-ebad-4f51-adf2-6199a41ea05a'
		postmark_token: postmark_token
		admin_email: admin_email
		admin_password: admin_password
	}
	vweb.run(app, 8080)
}
