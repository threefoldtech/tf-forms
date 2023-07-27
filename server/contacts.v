module main

import json
import vweb

struct Interests {
	tf_cloud        bool
	venture_creator bool
	licenses        bool
	dk              bool
}

struct Contact {
	email     string
	phone     string
	about     string
	interests Interests
}

fn (c Contact) to_json() string {
	return json.encode(c)
}

[middleware: check_auth]
['/contacts'; post]
fn (mut app App) create_or_update_contact() vweb.Result {
	contact := json.decode(Contact, app.req.data) or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{400, invalid_json}
		return app.json(er.to_json())
	}

	app.contacts[contact.email] = contact
	app.set_status(201, 'created')
	return app.json(contact.to_json())
}

[middleware: check_auth]
['/contacts'; get]
fn (mut app App) get_contact() vweb.Result {
	email := app.query['email'] or {
		app.set_status(400, 'Bad Request')
		er := CustomResponse{404, contact_not_found}
		return app.json(er.to_json())
	}
	contact := app.contacts[email] or {
		app.set_status(404, 'Not Found')
		er := CustomResponse{404, contact_not_found}
		return app.json(er.to_json())
	}
	// found Contact, return it
	ret := json.encode(contact)
	app.set_status(200, 'OK')
	return app.json(ret)
}

// [middleware: check_admin]
['/contacts/all'; get]
fn (mut app App) get_contacts() vweb.Result {
	mut contacts := []Contact{}

	contacts_map := app.contacts.clone()
	for _, contact in contacts_map {
		contacts << contact
	}
	ret := json.encode(contacts)
	app.set_status(200, 'OK')
	return app.json(ret)
}
