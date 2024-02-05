import 'package:flutter/material.dart';

class ConfirmTransactionPage extends StatelessWidget {
  const ConfirmTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please review the selected products and the total amount to confirm the transaction.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle CLEAR action
                print('CLEAR');
              },
              child: Text('CLEAR'),
            ),

            SizedBox(height: 16),
            TransactionItem(
              productName: 'Amata y’inyange 1L',
              quantity: 1,
              pricePerUnit: 1000,
              total: 1000,
            ),
            TransactionItem(
              productName: 'Juice',
              quantity: 1,
              pricePerUnit: 1000,
              total: 1000,
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sub-total'),
                Text('RWF 2000'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sales Tax (18%)'),
                Text('RWF 360'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total'),
                Text('RWF 2360'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

            CustomIconButton(
              label: 'CUSTOMER',
              icon: Icons.person,
              onPressed: () {
                // Handle CUSTOMER action
                print('CUSTOMER');
              },
            ),
             CustomIconButton(
              label: 'PAYMENT METHOD',
              icon: Icons.payment,
              onPressed: () {
                // Handle PAYMENT METHOD action
                print('PAYMENT METHOD');
              },
            ),
              ],
            ),
            SizedBox(height: 16),
           Center(
            child:  ElevatedButton(
              onPressed: () {
                // Handle Confirm Transaction
                print('Confirm Transaction');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 118, 34, 49), // Set the background color to purple dark
              ),
              child: Text('Confirm Transaction'),
            ),
           )
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(100.0); // Increase the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 82, 14, 47),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          // Handle back button press
        },
      ),
      title: Row(
        children: [
          // Icon(Icons.category, color: Colors.white),
          SizedBox(width: 8),
          Text('Confirm Transaction', style: TextStyle(color: Colors.white)),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Open search functionality here
            // showSearch(context: context, delegate: CustomSearchDelegate());
          },
        ),
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String productName;
  final int quantity;
  final int pricePerUnit;
  final int total;

  const TransactionItem({
    Key? key,
    required this.productName,
    required this.quantity,
    required this.pricePerUnit,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('QTY $quantity x $pricePerUnit'),
            Text('RWF $total'),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

