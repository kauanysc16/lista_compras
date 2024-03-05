import 'package:flutter/material.dart';
import 'package:lista_compras/ListaController.dart';


class ListaView extends StatefulWidget {
  final ListaController controller;

  ListaView({required this.controller});

  @override
  _ListaViewState createState() => _ListaViewState();
}

class _ListaViewState extends State<ListaView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String dropdownValue = '1';

  bool isSorted = false;

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
                    _addItem();
                  },
                  child: Text('Adicionar'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _toggleSort();
                  },
                  child: Text(isSorted ? 'Ordenado' : 'Ordenar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.controller.items.length + 1,
              itemBuilder: (context, index) {
                if (index < widget.controller.items.length) {
                  // Mostra os itens da lista
                  return ListTile(
                    title: Text(
                        '${widget.controller.items[index].name} - ${widget.controller.items[index].price.toStringAsFixed(2)} x ${widget.controller.items[index].quantity}'),
                    subtitle: Text(
                        'Total: \$${(widget.controller.items[index].price * widget.controller.items[index].quantity).toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteItem(index);
                      },
                    ),
                  );
                } else {
                  // Mostra o custo total
                  return ListTile(
                    title: Text(
                      'Total: \$${widget.controller.calculateTotal().toStringAsFixed(2)}',
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

  void _addItem() {
    String name = nameController.text;
    double price = double.parse(priceController.text);
    int quantity = int.parse(dropdownValue);

    widget.controller.addItem(name, price, quantity);

    nameController.clear();
    priceController.clear();
    dropdownValue = '1';

    setState(() {}); // Atualizar a exibição após adicionar um item
  }

  void _deleteItem(int index) {
    widget.controller.deleteItem(index);
    setState(() {}); // Atualizar a exibição após excluir um item
  }

  void _toggleSort() {
    widget.controller.toggleSort();
    setState(() {}); // Atualizar a exibição após alterar a ordenação
  }
}
