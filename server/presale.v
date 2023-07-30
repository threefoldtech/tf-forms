module main

import json
import vweb

struct Order {
	item     string
	quantity string
}

struct Presale {
	email        string
	phone        string
	referal_code string
	phone_orders []Order
	node_orders  []Order
	reason       string
}

fn (c Presale) to_json() string {
	return json.encode(c)
}

[middleware: check_auth]
['/presales'; post]
pub fn (mut app App) create_or_update_presale() vweb.Result {
	presale := json.decode(Presale, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, invalid_json}
		return app.json(er.to_json())
	}

	presales[presale.email] = presale
	app.set_status(201, 'created')
	return app.json(presale.to_json())
}

[middleware: check_auth]
['/presales'; get]
fn (mut app App) get_presale() vweb.Result {
	email := app.query['email'] or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{404, contact_not_found}
		return app.json(er.to_json())
	}
	presale := presales[email] or {
		app.set_status(404, 'Not Found')
		er := CustomResponse{404, presale_not_found}
		return app.json(er.to_json())
	}
	// found presale, return it
	ret := json.encode(presale)
	app.set_status(200, 'OK')
	return app.json(ret)
}

[middleware: check_admin]
['/presales/all'; get]
fn (mut app App) get_presales() vweb.Result {
	mut presales_list := []Presale{}
	for _, presale in presales {
		presales_list << presale
	}
	ret := json.encode(presales_list)
	app.set_status(200, 'OK')
	return app.json(ret)
}
