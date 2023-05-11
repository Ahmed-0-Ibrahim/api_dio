import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  String? imageUrl, name, price, oldPrice, discount;

  ProductWidget(
      {Key? key,
      this.imageUrl,
      this.name,
      this.price,
      this.oldPrice,
      this.discount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Image.network(imageUrl!, fit: BoxFit.cover),
        ),
        SizedBox(
          height: 100,
          width: 230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name!,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${price!} EG",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    "${oldPrice!} EG",
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        ),
        Text('Discount \n$discount %',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
