import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

class SocketClient {
  final _manager = SocketIOManager();
  SocketIO _socket;

  conect(String token, String chatId, String userId) async {
    final options = SocketOptions(AppConfig.apiSocket,
        query: {"token": token},
        enableLogging: true,
        transports: [Transports.POLLING]);
    _socket = await _manager.createInstance(options);

    _socket.onConnect((data) {
      print('Conectado: ${data.toString()}');

      _socket.emit('joinGroup', [chatId, userId]);
    });
    _socket.on('notAuthorizedError', (data) {
      print('Error de autorizacion: : : : ${data.toString()}');
    });

    _socket.on('chatHistory', (data) {
      print('Historial de Chat ${data.toString()}');
    });
    _socket.on('connect_error', (data) {
      print('Error de conexion::::::: ${data.toString()}');
    });
    _socket.onConnectError((data) {
      print('Error de conexion::::::: ${data.toString()}');
    });
    _socket.onDisconnect((data) {
      print('Desconectado con exito');
    });

    _socket.connect();
  }

  disconnect() async {
    await _manager.clearInstance(_socket);
  }
}
