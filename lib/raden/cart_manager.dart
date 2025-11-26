class CartItem {
  final String name;
  final String price;
  final DateTime selectedDay;

  CartItem({
    required this.name,
    required this.price,
    required this.selectedDay,
  });
}

class CartManager {
  static final CartManager _instance = CartManager._internal();

  factory CartManager() => _instance;

  CartManager._internal();

  final List<CartItem> cart = [];

  void addToCart(CartItem item) {
    cart.add(item);
  }

  void removeFromCart(CartItem item) {
    cart.remove(item);
  }
}
