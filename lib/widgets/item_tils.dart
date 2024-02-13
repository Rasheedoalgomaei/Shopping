import 'package:calculator/models/item.dart';
import 'package:calculator/models/provider_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemTils extends StatelessWidget {
  final Items items;
  ItemTils(this.items);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: false,
        onChanged: (bool? value) {},
      ),
      title: Text(
        items.name,
        style: TextStyle(color: context.read<ProviderData>().itemcolor),
      ),
      trailing: ElevatedButton.icon(
        onPressed: () {
          context.read<ProviderData>().itemcolor = Colors.amber;
          context.read<ProviderData>().changeStyle();
          context.read<ProviderData>().remveItem(items);
        },
        icon: const Icon(Icons.person),
        label: Text(
          'item',
        ),
      ),
      onTap: () {},
    );
  }
}
