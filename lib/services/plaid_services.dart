import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

// Emulating Server-Side call
abstract class PlaidServices {
  static Future<String> createPlaidToken() async {
    final response = await http.post(
      Uri.parse("https://sandbox.plaid.com/link/token/create"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "client_id": dotenv.env['CLIENT_ID'],
        "secret": dotenv.env['SECRET'],
        "client_name": "Plaid Demo",
        "user": {
          "client_user_id": const Uuid().v4(),
        },
        "products": ["auth"],
        "country_codes": ["US"],
        "language": "en",
      }),
    );

    return jsonDecode(response.body)['link_token'];
  }
}
