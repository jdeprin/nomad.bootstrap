from flask import Flask
import requests
from random import randint

my_app = Flask(__name__)


@my_app.route('/')
def app():
	r = requests.get('https://www.metaweather.com/api/location/search/?query=san')
	return r.text


@my_app.route('/health')
def health():
	return '{"status": "UP"}'


if __name__ == '__main__':
	my_app.run(debug=True, host='0.0.0.0', port=7654)
