module main

import json

struct CustomResponse {
	status  int
	message string
}

fn (c CustomResponse) to_json() string {
	return json.encode(c)
}

const (
	invalid_json         = 'Invalid JSON Payload'
	contact_not_found    = 'Contact not found'
	investment_not_found = 'Investment not found'
	presale_not_found    = 'Presale not found'
)
