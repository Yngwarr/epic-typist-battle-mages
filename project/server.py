import ssl
from http.server import HTTPServer, SimpleHTTPRequestHandler


class MyHTTPRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
        super().end_headers()


httpd = HTTPServer(("localhost", 8000), MyHTTPRequestHandler)

# Uncomment the following lines to use HTTPS
# httpd.socket = ssl.wrap_socket(httpd.socket,
#                                keyfile="path/to/key.pem",
#                                certfile='path/to/cert.pem', server_side=True)

print("Serving on port 8000")
httpd.serve_forever()
