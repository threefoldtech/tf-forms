module main

import json
import vweb

struct Interests {
	id              int  [primary; sql: serial]
	contact_id      int
	tf_cloud        bool
	venture_creator bool
	licenses        bool
	dk              bool
}

struct Contact {
	id        int       [primary; sql: serial]
	email     string    [primary; unique]
	phone     string    [unique]
	about     string
	interests Interests [fkey: 'contact_id']
}



[middleware: check_auth]
['/contacts'; post]
fn (mut app App) create_or_update_contact() !vweb.Result {
	contact := json.decode(Contact, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, 'Failed to decode contact data'}
		return app.json(er)
	}
	contacts := sql app.db {
		select from Contact where email == contact.email
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	// delete old entry
	if contacts.len > 0 {
		sql app.db {
			delete from Contact where email == contact.email
		} or {
			app.set_status(500, 'Failed to Delete contact')
			return app.text('${err}')
		}
	}
	sql app.db {
		insert contact into Contact
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	// contacts[contact.email] = contact
	app.set_status(201, 'created')
	return app.json(contact)
}

[middleware: check_auth]
['/contacts'; get]
fn (mut app App) get_contact() vweb.Result {
	email := app.query['email'] or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{404, contact_not_found}
		return app.json(er)
	}
	contacts := sql app.db {
		select from Contact where email == email
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	if contacts.len < 1 {
		app.set_status(404, 'Not Found')
		er := CustomResponse{404, contact_not_found}
		return app.json(er)
	}
	// found Contact, return it
	app.set_status(200, 'OK')
	return app.json(contacts[0])
}

[middleware: check_admin]
['/contacts/all'; get]
fn (mut app App) get_contacts() vweb.Result {
	contacts := sql app.db {
		select from Contact
	} or {
		app.set_status(500, 'Server Error')
		return app.text('${err}')
	}
	app.set_status(200, 'OK')
	return app.json(contacts)
}
