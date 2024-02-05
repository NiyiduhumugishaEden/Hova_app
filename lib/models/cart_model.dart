import 'item_model.dart';

class Cart {
  List<Item> _items = [];

  Cart();// Retrieve all cart items
  List<Item> get items => _items;

  // Add item to cart
  void addItem(Item item) {
    // Check if item already exists in cart
    int index = _items.indexWhere((existingItem) => existingItem.id == item.id);
    if (index != -1) {
      // If exists, increase quantity
      _items[index].quantity += 1;
    } else {
      // If not exists, add to cart with quantity 1
      _items.add(Item(id: item.id, name: item.name, price: item.price, quantity: 1));
    }
  }

  // Remove item from cart
  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
  }

  // Update item quantity
  void updateItemQuantity(String itemId, int quantity) {
    int index = _items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _items[index].quantity = quantity;
    }
  }

  // Get total price of all items in cart
  double get total => _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
