import 'package:computer_app/models/ComputerParts.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Computer>?> getComputers() async {
    var client = http.Client();

    var uri = Uri.parse('https://computers-shop.vercel.app/computers');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return computerFromJson(json);
    }
    else {
      // If the status code is not 200, handle the error or return a default value.
      // For example, return an empty list.
      return <Computer>[];
    }
  }
}
