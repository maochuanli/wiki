#!/usr/bin/env python

import os
import cgi

class upfile(object):

    def __init__(self):
        self.script_dir = os.path.dirname(__file__)
        self.errors = []


    def __call__(self, environ, start_response):
        f = open(os.path.join('/var/www/html', 'index.html'))
        self.output = f.read()
        f.close()

        self.response_content_type = 'text/html;charset=UTF-8'
        fields = None
        if 'POST' == environ['REQUEST_METHOD'] :
            fields = cgi.FieldStorage(fp=environ['wsgi.input'],environ=environ, keep_blank_values=1)
            fileitems = fields.list
	    if fileitems:
		for item in fileitems:
		    self.output += item.filename
                    #fn = os.path.basename(item.filename)
                    open('/tmp/' + item.filename, 'wb').write(item.value)


        response_headers = [('Content-type', self.response_content_type),('Content-Length', str(len(self.output)))]
        status = '200 OK'
        start_response(status, response_headers)
        return [self.output]


application = upfile()
