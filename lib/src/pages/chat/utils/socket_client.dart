import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  Socket socket ;

  initConnection (String token){
    var parsed = Uri.parse('https://lita-261516.appspot.com/');
    print(parsed.path);
    print("domain ${parsed.port}");

    socket = io('https://lita-261516.appspot.com/', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'extraHeaders': {
    "Sec-WebSocket-Version": "13",
    "Accept-Encoding": "gzip, deflate",
    "Sec-WebSocket-Key": "ouTy2cAv7Du/LfDP0zFSlQ==",
    "Sec-WebSocket-Extensions": "permessage-deflate; client_max_window_bits"
      }

    });
    socket.connect();
    socket.on('connect_error',(data){
      print('error al conectar ${data.toString()}');
    });
  }
}
