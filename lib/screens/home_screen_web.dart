
import 'package:flutter/material.dart';

class HomeScreenWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hova '),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView(
                children: [
                  DrawerHeader(child: Text('PRODUCTS')),
                  ListTile(title: Text('Laptop Charger')),
                  ListTile(title: Text('Phone Charger')),
                  // Add more items...
                ],
              ),
            ),
          ),
          // Main Content and Transaction Summary
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // Content Area
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Adjust number based on your screen size
                    ),
                    itemCount: 20, // Number of products
                    itemBuilder: (context, index) => Card(
                      child: Center(child: Text('Product $index')),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Left Content (Transaction Summary)
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Transaction Summary',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  // Add your transaction summary content here...
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
