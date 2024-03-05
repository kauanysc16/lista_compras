import 'ListaModel.dart';

class ListaController {
  List<Item> items = [];

  void addItem(String name, double price, int quantity) {
    items.add(Item(name: name, price: price, quantity: quantity));
  }

  void deleteItem(int index) {
    items.removeAt(index);
  }

  void toggleSort() {
    items.sort((a, b) => a.name.compareTo(b.name));
  }

  double calculateTotal() {
    double total = 0.0;
    for (Item item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
