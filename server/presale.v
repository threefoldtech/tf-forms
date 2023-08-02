module main

import json
import vweb

struct Order {
	id         int    [primary; sql: serial]
	item       string
	quantity   string
	presale_id int
}

struct Presale {
	id           int     [primary; sql: serial]
	email        string  [primary; unique]
	phone        string  [unique]
	referal_code string
	reason       string
	phone_orders []Order [fkey: 'presale_id']
	node_orders  []Order  [fkey: 'presale_id']
	
}

[middleware: check_auth]
['/presales'; post]
pub fn (mut app App) create_or_update_presale() vweb.Result {
	presale := json.decode(Presale, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, invalid_json}
		return app.json(er)
	}
	presales := sql app.db {
		select from Presale where email == presale.email
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	// delete old entry
	if presales.len > 0 {
		sql app.db {
			delete from Presale where email == presale.email
		} or {
			app.set_status(500, 'Failed to Delete presale')
			return app.text('${err}')
		}
	}
	sql app.db {
		insert presale into Presale
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}

	app.set_status(201, 'created')
	return app.json(presale)
}

[middleware: check_auth]
['/presales'; get]
fn (mut app App) get_presale() vweb.Result {
	email := app.query['email'] or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{404, presale_not_found}
		return app.json(er)
	}
	presales := sql app.db {
		select from Presale where email == email
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	if presales.len < 1 {
		app.set_status(404, 'Not Found')
		er := CustomResponse{404, presale_not_found}
		return app.json(er)
	}

	// found presale, return it
	app.set_status(200, 'OK')
	return app.json(presales[0])
}

[middleware: check_admin]
['/presales/all'; get]
fn (mut app App) get_presales() vweb.Result {
	presales := sql app.db {
		select from Presale
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	app.set_status(200, 'OK')
	return app.json(presales)
}
