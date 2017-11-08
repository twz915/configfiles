# -*- coding: utf-8  -*-
"""
A simple Proxy for https://httpbin.org/ip
WeizhongTu
"""
import logging

import requests
from flask import Flask, request
from flask import jsonify

app = Flask(__name__.split('.')[0])
logging.basicConfig(level=logging.INFO)
LOG = logging.getLogger("proxy")


@app.route('/<path:url>')
def root(url):
    to_url = "https://httpbin.org/%s%s" % (url, ("?" + request.query_string if request.query_string else ""))
    LOG.info("visit: %s", to_url)
    req = requests.get(to_url)
    data = req.json()
    patch_data(data)
    return jsonify(data)


def patch_data(data):
    pass


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
