module main

import json
import vweb

struct Investment {
	email          string
	phone          string
	referal_code   string
	invest_slots   string
	invest_venture string
	invest_tf      string
}

fn (c Investment) to_json() string {
	return json.encode(c)
}

[middleware: check_auth]
['/invests'; post]
pub fn (mut app App) create_or_update_investment() vweb.Result {
	investment := json.decode(Investment, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, invalid_json}
		return app.json(er.to_json())
	}

	investments[investment.email] = investment
	app.set_status(201, 'created')
	return app.json(investment.to_json())
}

[middleware: check_auth]
['/invests/'; get]
fn (mut app App) get_investment() vweb.Result {
	email := app.query['email'] or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{404, contact_not_found}
		return app.json(er.to_json())
	}
	investment := investments[email] or {
		app.set_status(404, 'Not Found')
		er := CustomResponse{404, investment_not_found}
		return app.json(er.to_json())
	}
	ret := json.encode(investment)
	app.set_status(200, 'OK')
	return app.json(ret)
}

[middleware: check_admin]
['/invests/all'; get]
fn (mut app App) get_investments() vweb.Result {
	mut investments_list := []Investment{}
	for _, invest in investments {
		investments_list << invest
	}
	ret := json.encode(investments_list)
	app.set_status(200, 'OK')
	return app.json(ret)
}
