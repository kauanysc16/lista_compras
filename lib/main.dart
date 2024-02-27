import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Item {
  String name;
  double price;
  int quantity;

  Item({required this.name, required this.price, this.quantity = 1});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingList(),
    );
  }
}

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<Item> items = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome do item',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: 'Preço',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['1', '2', '3', '4', '5']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    addItem();
                  },
                  child: Text('Adicionar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${items[index].name} - \$${items[index].price.toStringAsFixed(2)}'),
                  subtitle: Text('Quantidade: ${items[index].quantity}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void addItem() {
    String name = nameController.text;
    double price = double.parse(priceController.text);
    int quantity = int.parse(dropdownValue);

    setState(() {
      items.add(Item(name: name, price: price, quantity: quantity));
    });

    // Limpa os campos de entrada
    nameController.clear();
    priceController.clear();
    dropdownValue = '1';
  }
}
