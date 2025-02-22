import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class WebServer {
  final int port;
  late HttpServer _server;
  final Pipeline _pipeline;
  final Router _router;

  WebServer({this.port = 8080})
      : _pipeline = Pipeline(),
        _router = Router();

  void useMiddleware(Middleware middleware) {
    _pipeline.addMiddleware(middleware);
  }

  void addRoute(String path, Handler handler, {String method = 'GET'}) {
    switch (method.toUpperCase()) {
      case 'GET':
        _router.get(path, handler);
        break;
      case 'POST':
        _router.post(path, handler);
        break;
      case 'PUT':
        _router.put(path, handler);
        break;
      case 'DELETE':
        _router.delete(path, handler);
        break;
      default:
        throw ArgumentError('Invalid HTTP method: $method');
    }
  }

  Future<void> start() async {
    final handler = _pipeline.addHandler(_router);
    _server = await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
    print('Web server running on port $port');
  }

  Future<void> stop() async {
    await _server.close();
    print('Web server stopped');
  }
}

final webServer = WebServer();
