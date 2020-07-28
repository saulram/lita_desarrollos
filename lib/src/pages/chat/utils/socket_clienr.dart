import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:litadesarrollos/src/utils/globals.dart';
typedef void OnNewMessage (dynamic data);
typedef void OnMessageSent (dynamic data);


class SocketClient {
  final _manager = SocketIOManager();
  SocketIO _socket;
  OnNewMessage onNewMessage;
  OnMessageSent onMessageSent;

  conect(String token, String chatId, String userId) async {
    final options = SocketOptions(AppConfig.apiSocket,
        query: {"token": token},
        enableLogging: true,
        transports: [Transports.POLLING],);

    _socket = await _manager.createInstance(options);

    _socket.onConnect((data) {
      print('Conectado: ${data.toString()}');

      _socket.emit('joinGroup', [chatId, userId]);
    });
    _socket.on('connect', (data) {
      print('Conectado');
    });
    
    _socket.on('notAuthorizedError', (data) {
      print('Error de autorizacion: : : : ${data.toString()}');
    });

    _socket.on('chatHistory', (data) {
      print('Conectado al grupo :::::::');

      if(onNewMessage!=null){
        onNewMessage(data);
      }
    });
    _socket.onConnectTimeout((data) {
      print('Conection Timeout');
    });
    _socket.onConnecting((data) {
      print('Conectando...');
    });
    _socket.onReconnect((data) {
      print('Reconectando');
    });

    _socket.on('updateChat',(data){
      print('Mensaje enviado/recibido : $data');


      if(onMessageSent!=null){
        onMessageSent(data);
      }
    });
    _socket.on('updateChatError',(data){
      print('Eror al guardar el mensaje: $data');
      if(onMessageSent!=null){
        onMessageSent(data);
      }
    });
    _socket.onConnectError((data) {
      print('Error de conexion::::::: ${data.toString()}');
    });
    _socket.onDisconnect((data) {
      print('Desconectado con exito');
    });

    _socket.connect();
  }
  sendmessage(String text,chatId,user_id) async {


    await _socket.emit('updateChat',[text,chatId,user_id]);
    print("Emitiendo mensaje con texto $text, para el chat : $chatId  y con el user   : $user_id");



  }



  disconnect() async {
    await _manager.clearInstance(_socket);
  }
}
