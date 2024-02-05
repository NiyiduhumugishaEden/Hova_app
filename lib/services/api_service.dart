import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://65bf892725a83926ab952a17.mockapi.io/transactions';

  Future<List<dynamic>> getItems() async {
    var response = await http.get(Uri.parse('$baseUrl/items'));
    return json.decode(response.body);
  }


  //   Future<List<Transaction>> fetchTransactions() async {
  //   final response = await http.get(Uri.parse('https://65bf892725a83926ab952a17.mockapi.io/transactions'));
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((transaction) => Transaction.fromJson(transaction)).toList();
  //   } else {
  //     throw Exception('Failed to load transactions');
  //   }
  // }
}
