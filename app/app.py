from flask import Flask, request, jsonify
from flask_restful import Api, Resource, reqparse
import json
import datetime
import sys
import logging

app = Flask(__name__)

def get_latest_build(builds):
    build_dates = []
    for obj in builds['jobs']['Build base AMI']['Builds']:
        build_dates.append(int(obj['build_date']))
    index = build_dates.index(max(build_dates))
    output = builds['jobs']['Build base AMI']['Builds'][index]['output']
    out_json = {
                "date": datetime.datetime.fromtimestamp(max(build_dates)).strftime("%c"),
                "ami-id": output.split(" ")[-2],
                "hash": output.split(" ")[-1]
                }
    app.logger.info("Output: {}".format(out_json))                
    return jsonify(out_json)

@app.route('/builds',methods=['POST'])
def get_builds():
    builds = request.get_json()
    app.logger.info("Input: {}".format(builds))
    output = get_latest_build(builds)
    return output, 200

logging.basicConfig(filename='error.log',level=logging.DEBUG)
app.run(debug=True, host='0.0.0.0', port='80')