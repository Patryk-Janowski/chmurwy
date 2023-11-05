from flask import Blueprint, render_template, redirect, request, g, session, make_response, flash, jsonify
import libuser
import libsession
import requests
import libposts
import libapi
from jsonschema import validate, ValidationError
import os


mod_api = Blueprint('mod_api', __name__, template_folder='templates')

key_schema = {
    "type": "object",
    "required": ["username", "password"],
    "properties": {
        "username": {"type": "string", "pattern": "^[a-z]+$"},
        "password": {"type": "string"},
    },
    "additionalProperties": False,
}


post_schema = {
    "type": "object",
    "required": ["text"],
    "properties": {
        "text": {"type": "string"},
    },
    "additionalProperties": False,
}


@mod_api.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "OK"}), 200

@mod_api.route('/ip', methods=['GET'])
def get_ip():
    try:
        # Request token for IMDSv2
        token = requests.put('http://169.254.169.254/latest/api/token', 
                             headers={'X-aws-ec2-metadata-token-ttl-seconds': '21600'}, 
                             timeout=2).text
        
        # Using the token to retrieve instance's public IP
        ip = requests.get('http://169.254.169.254/latest/meta-data/public-ipv4', 
                          headers={'X-aws-ec2-metadata-token': token}, 
                          timeout=2).text
    except requests.RequestException as e:
        ip = f"Unable to get IP: {str(e)}"
    return jsonify(ip_address=ip)

@mod_api.route('/key', methods=['POST'])
def do_key_create():
    data = request.get_json()

    try:
        validate(data, key_schema)
    except ValidationError:
        return jsonify({'error': 'invalid schema', 'schema': key_schema}, 400)

    key = libapi.keygen(data['username'], data['password'])

    if key:
        return jsonify({'key': key}), 200
    else:
        return jsonify({'error': 'invalid login'}), 200


@mod_api.route('/post/<username>', methods=['GET'])
def do_post_list(username):
    posts = libposts.get_posts(username)

    return jsonify(posts)


@mod_api.route('/post', methods=['POST'])
def do_post_create():

    username = libapi.authenticate(request)

    if not username:
        return jsonify({'error': 'invalid authentication'}), 401

    print(request.get_json())
    return "You are awesome! Post created."
