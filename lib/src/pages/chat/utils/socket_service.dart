import 'package:litadesarrollos/src/utils/globals.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketService {
  IO.Socket socket;

  createSocketConnection() {
    socket = IO.io(AppConfig.apiSocket, <String, dynamic>{
      'transports': ['polling'],
    });

    this.socket.on("connect", (_) => print('Connected'));
    this.socket.on("disconnect", (_) => print('Disconnected'));
    this.socket.on("connect_error",(data)=>print('Error al conectar ${data.toString()}'));
  }
}