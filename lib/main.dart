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

  bool isSorted = false; // Variável para rastrear se a lista está ordenada

  @override
  Widget build(BuildContext context) {
    double total = 0.0;

    // Calcula o custo total dos itens
    for (Item item in items) {
      total += item.price * item.quantity;
    }

    // Ordena os itens por nome em ordem alfabética
    if (isSorted) {
      items.sort((a, b) => a.name.compareTo(b.name));
    }

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
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    toggleSort();
                  },
                  child: Text(isSorted ? 'Ordenado' : 'Ordenar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length + 1, // +1 para incluir o total
              itemBuilder: (context, index) {
                if (index < items.length) {
                  // Mostra os itens da lista
                  return ListTile(
                    title: Text(
                        '${items[index].name} - ${items[index].price.toStringAsFixed(2)} x ${items[index].quantity}'),
                    subtitle: Text(
                        'Total: \$${(items[index].price * items[index].quantity).toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteItem(index);
                      },
                    ),
                  );
                } else {
                  // Mostra o custo total
                  return ListTile(
                    title: Text(
                      'Total: \$${total.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }
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

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void toggleSort() {
    setState(() {
      isSorted = !isSorted;
    });
  }
}
