from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


support = Blueprint('support', __name__)

# Get all customers from the DB
@support.route('/requests', methods=['GET'])
def get_requests():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT client.first_name, client.last_name, support_request.ticket_number, support_request.resolved,'
                   ' support_request.request_date FROM support_request INNER JOIN client '
                   'ON support_request.requested_by = client.client_id;')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@support.route('/details', methods=['GET'])
def get_full_request_details():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    req_id = int(request.args['req_id'])
    query = 'SELECT details FROM support_request WHERE ticket_number = "{}"'.format(req_id)
    cursor.execute(query)
    theData = cursor.fetchall()
    return theData[0][0]


