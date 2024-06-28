import ssl
from http.server import HTTPServer, SimpleHTTPRequestHandler


class MyHTTPRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
        super().end_headers()


httpd = HTTPServer(("0.0.0.0", 8000), MyHTTPRequestHandler)
# httpd = HTTPServer(("localhost", 8000), MyHTTPRequestHandler)

# Uncomment the following lines to use HTTPS
# Создание SSL контекста
ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
ssl_context.load_cert_chain(
    certfile="/home/svt/dev/epic-typist-battle-mages/frontend/exported/cert.pem",
    keyfile="/home/svt/dev/epic-typist-battle-mages/frontend/exported/key.pem",
)

# Обертывание сокета сервера с SSL
httpd.socket = ssl_context.wrap_socket(httpd.socket, server_side=True)

print("Serving on port 8000")
httpd.serve_forever()
