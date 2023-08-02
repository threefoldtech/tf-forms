module main

import json
import vweb

struct Investment {
	id             int    [primary; sql: serial]
	email          string [primary; unique]
	phone          string [unique]
	referal_code   string
	invest_slots   string
	invest_venture string
	invest_tf      string
}

[middleware: check_auth]
['/invests'; post]
pub fn (mut app App) create_or_update_investment() vweb.Result {
	investment := json.decode(Investment, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, invalid_json}
		return app.json(er)
	}

	investments := sql app.db {
		select from Investment where email == investment.email
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	// delete old entry
	if investments.len > 0 {
		sql app.db {
			delete from Investment where email == investment.email
		} or {
			app.set_status(500, 'Failed to Delete invesment')
			return app.text('${err}')
		}
	}
	sql app.db {
		insert investment into Investment
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	app.set_status(201, 'created')
	return app.json(investment)
}

[middleware: check_auth]
['/invests/'; get]
fn (mut app App) get_investment() vweb.Result {
	email := app.query['email'] or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{404, investment_not_found}
		return app.json(er)
	}
	investments := sql app.db {
		select from Investment where email == email
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	if investments.len < 1 {
		app.set_status(404, 'Not Found')
		er := CustomResponse{404, investment_not_found}
		return app.json(er)
	}
	app.set_status(200, 'OK')
	return app.json(investments[0])
}

[middleware: check_admin]
['/invests/all'; get]
fn (mut app App) get_investments() vweb.Result {
	investments := sql app.db {
		select from Investment
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	app.set_status(200, 'OK')
	return app.json(investments)
}
