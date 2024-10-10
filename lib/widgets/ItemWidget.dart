import 'package:flutter/material.dart';
import 'package:mid_term_1/models/product.dart';

class ItemWidget extends StatelessWidget {
  final Product item;
  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.image),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                  const TextSpan(
                      text: 'Tên SP: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: item.name)
                ])),
            RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                  const TextSpan(
                      text: 'Loại SP: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: item.name)
                ])),
            RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                  const TextSpan(
                      text: 'Giá: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: item.name)
                ])),
          ],
        ),
        trailing: SizedBox(
            width: 70,
            child: Row(
              children: [
                InkWell(
                  onTap: () => {},
                  child: const Icon(Icons.edit),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.delete),
                )
              ],
            )),
      ),
    );
  }
}
