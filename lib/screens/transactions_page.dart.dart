
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late Future<List<Transaction>> transactions;
  int cartCount = 0;
  String filter = '';

  void incrementCartCount() {
    setState(() {
      cartCount++;
    });
  }

  @override
  void initState() {
    super.initState();
    transactions = fetchTransactions();
  }

  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(Uri.parse('https://65bf892725a83926ab952a17.mockapi.io/transactions'));
    if (response.statusCode == 200) {
      List<dynamic> transactionsJson = json.decode(response.body);
      return transactionsJson.map((transactionJson) => Transaction.fromJson(transactionJson)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(cartCount: cartCount),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter search term',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Transaction>>(
              future: transactions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No transactions found'));
                } else {
                  // Filter the list based on the search term
                  var filteredTransactions = snapshot.data!.where((transaction) {
                    return transaction.title.toLowerCase().contains(filter.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      Transaction transaction = filteredTransactions[index];
                      return CardPage(
                        productName: transaction.title,
                        price: 'RWF ${transaction.amount}',
                        status: transaction.status,
                        date: transaction.date,
                        onAddToCart: incrementCartCount,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


class Transaction {
  final String id;
  final String title;
  final String amount;
  final String date;
  final String status;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    var date = DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000).toIso8601String();

    return Transaction(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: date,
      status: json['status'],
    );
  }
}


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartCount;

  CustomAppBar({this.cartCount = 0});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 83, 28, 43),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop(); // Assuming this button should pop back the navigation stack
        },
      ),
      title: Text('Transactions Page', style: TextStyle(color: Colors.white)),
      actions: [
        // Other actions...
        Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigate to cart page or open cart overlay
              },
            ),
            if (cartCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$cartCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}


class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Suggestions for: $query'),
    );
  }
}



class CardPage extends StatelessWidget {
   final VoidCallback onAddToCart; // Add this line

  final String productName;
  final String price;
  final String status;
  final String date;

  const CardPage({
    Key? key,
    required this.productName,
    required this.price,
    required this.status,
    required this.date,
    required this.onAddToCart,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              // This should be replaced with the icon or image for the product
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.computer, color: Colors.white),
            ),
            title: Text(
              productName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // TODO: Implement menu button functionality
              },
            ),
          ),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' $price',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement add to cart functionality
                    onAddToCart(); // Add this line
                  
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // This is your color
                  ),
                   
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(color: Colors.white),
                    ),
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
