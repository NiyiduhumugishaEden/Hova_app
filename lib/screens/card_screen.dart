import 'package:flutter/material.dart';


class CardPage extends StatelessWidget {
  final String productName;
  final String price;
  final String status;
  final String date;
  final VoidCallback onAddToCart;

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
    Color statusColor;
    String statusText;
    Function()? onButtonPressed;

    switch (status) {
      case 'In Stock':
        statusColor = Colors.green;
        statusText = 'ADD TO CART';
        onButtonPressed = onAddToCart;
        break;
      case 'Already added':
        statusColor = Colors.orange;
        statusText = 'ALREADY ADDED';
        onButtonPressed = null;
        break;
      case 'Out of stock':
        statusColor = Colors.red;
        statusText = 'OUT OF STOCK';
        onButtonPressed = null;
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'UNKNOWN STATUS';
        onButtonPressed = null;
    }

    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(productName[0], style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 16),
                Expanded(child: Text(productName, style: TextStyle(fontSize: 18))),
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {
                    // Implement what should happen when this button is pressed
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 1, color: Colors.grey),
            SizedBox(height: 8),
            Row(
              children: [
                Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Spacer(),
                ElevatedButton(
                  onPressed: onButtonPressed,
                  child: Text(statusText),
                  style: ElevatedButton.styleFrom(
                    primary: statusColor,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// class CardPage extends StatelessWidget {
//   final String productName;
//   final String price;
//   final String status;
//   final String date;
//   final VoidCallback onAddToCart;

//   const CardPage({
//     Key? key,
//     required this.productName,
//     required this.price,
//     required this.status,
//     required this.date,
//     required this.onAddToCart,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       elevation: 4,
//       shadowColor: Colors.deepPurpleAccent,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.deepPurple,
//                   child: Text(
//                     productName[0],
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Text(
//                   productName,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.more_vert),
//                   onPressed: () {
//                     // More actions
//                   },
//                 ),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   price,
//                   style: TextStyle(fontSize: 18, color: Colors.green[700]),
//                 ),
//                 TextButton(
//                   onPressed: onAddToCart,
//                   child: Text('ADD TO CART'),
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     primary: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }