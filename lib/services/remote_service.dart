import 'package:computer_app/models/ComputerParts.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Computer>?> getComputers() async {
    var client = http.Client();

    var uri = Uri.parse('https://computer-parts-api.vercel.app/computers');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return computerFromJson(json);
    }
  }
}
