import 'package:computer_app/base_net.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadPC() {
    return BaseNetwork.get("computers");
  }

  Future<Map<String, dynamic>> loadDetailPC(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("computers/$id");
  }
}