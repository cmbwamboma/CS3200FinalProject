from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


clients = Blueprint('clients', __name__)

# Get all customers from the DB
@clients.route('/clients', methods=['GET'])
def get_customers():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT client.first_name, client.last_name, client.email, pm.manager_id, pm.full_name, pm.aum, pm.active_or_passive FROM client '
                   'JOIN (SELECT portfolio.aum, portfolio.active_or_passive, portfolio.portfolio_id, manager.manager_id, manager.full_name '
                   'FROM portfolio JOIN manager ON portfolio.managed_by = manager.manager_id) as pm '
                   'ON client.portfolio = pm.portfolio_id')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@clients.route('/details', methods=['GET'])
def get_full_client_details():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    cli_id = int(request.args['cli_id'])
    query = 'SELECT * FROM client WHERE client_id = "{}"'.format(cli_id)
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
