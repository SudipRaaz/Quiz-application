import 'package:http/http.dart' as http;

import '../models/Question.dart';

class Remote {
  Future<Question?> getQuestion() async {
    var client = http.Client();

    var uri = Uri.parse("http://marcconrad.com/uob/smile/api.php");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return questionFromJson(json);
    }
  }
}
