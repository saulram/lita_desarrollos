import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:litadesarrollos/src/pages/chat/utils/socket_service.dart';

class DependencyInjection {
  Injector initialise(Injector injector) {
    injector.map<SocketService>((i) => SocketService(), isSingleton: true);
    return injector;
  }
}