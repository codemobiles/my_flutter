import 'package:flutter/material.dart';
import 'package:my_flutter/src/models/product_response.dart';
import 'package:my_flutter/src/services/network_service.dart';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductResponse>>(
      future: NetworkService().getStock(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            setState(() {});
          },
          child: ItemCard(
            productList: snapshot.data.map((product) {
              if (product.image != null) {
                product.image =
                    NetworkService.baseURL + "/images/" + product.image;
              }
              return product;
            }).toList(),
          ),
        );
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  final List<ProductResponse> productList;

  const ItemCard({
    Key key,
    @required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(4),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        final product = productList[index];
        return _buildCard(product);
      },
      itemCount: productList == null ? 0 : productList.length,
    );
  }

  Card _buildCard(ProductResponse product) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Column(
        children: [
          _buildImage(product),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.name ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${product.price ?? "0"}"),
                    Text("${product.stock ?? "0"}"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack _buildImage(ProductResponse product) {
    return Stack(
      children: [
        product.image != null
            ? Image.network(
                product.image,
                height: 180,
              )
            : Container(
                height: 180,
                alignment: Alignment.center,
                child: Icon(
                  Icons.close,
                ),
              ),
        Positioned(
          top: 6,
          right: 2,
          child: Card(
            margin: EdgeInsets.all(0),
            color: Colors.orange,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text("best seller"),
            ),
          ),
        ),
      ],
    );
  }
}
