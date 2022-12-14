from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


portfolios = Blueprint('portfolios', __name__)

# Get all portfolios from the DB


@portfolios.route('/holdings', methods=['GET'])
def get_portfolio_holdings():
    current_app.logger.info(request.args)
    cursor = db.get_db().cursor()
    if 'port_id' not in request.args:
            return make_response('Error: parameter required', 400)
    port_id = int(request.args['port_id'])
    query = 'SELECT sec, quantity FROM holding WHERE portfol = "{}"'.format(port_id)
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

@portfolios.route('/security', methods=['GET'])
def get_security_details():
    current_app.logger.info(request.args)
    cursor = db.get_db().cursor()
    ticker = request.args['ticker']
    query = 'SELECT i.industry_name, i.sector, s.ticker, s.name, s.price, s.beta FROM holding h ' \
            'JOIN security s ON h.sec = s.ticker JOIN industry i ON s.industry = i.industry_id WHERE s.ticker = "{}"'.format(ticker)
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

@portfolios.route('/newholding', methods=['POST'])
def add_holding():
    cursor = db.get_db().cursor()
    ticker = request.form['ticker']
    quantity = int(request.form['quantity'])
    portfolio = int(request.form['portfolio'])
    query = f'INSERT INTO holding (portfol, sec, quantity) values (' + str(portfolio) + ', "' + ticker + '", ' \
            + str(quantity) + ')'
    cursor.execute(query)
    db.get_db().commit()
    return "DONE!"
