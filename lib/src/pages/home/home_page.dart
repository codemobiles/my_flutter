import 'package:flutter/material.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:my_flutter/src/models/product_response.dart';
import 'package:my_flutter/src/services/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Stock"),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences.getInstance().then((pref) {
                pref.remove(Constants.PREF_TOKEN);
                //pref.clear();

                Navigator.pushNamedAndRemoveUntil(
                    context,
                    Constants.LOGIN_ROUTE,
                    (
                      Route<dynamic> route,
                    ) =>
                        false);
              });
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: FutureBuilder<List<ProductResponse>>(
        future: NetworkService().getStock(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ItemCard(
            productList: snapshot.data.map((product) {
              product.image =
                  NetworkService.baseURL + "/images/" + product.image;
              return product;
            }).toList(),
          );
        },
      ),
      // context
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
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
      child: Column(
        children: [
          _buildImage(product),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.price.toString()),
                    Text(product.stock.toString()),
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
        Image.network(
          product.image,
          height: 180,
        ),
        Positioned(
          top: 6,
          right: 2,
          child: Card(
            margin: EdgeInsets.all(0),
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text("best seller"),
            ),
          ),
        ),
      ],
    );
  }
}
