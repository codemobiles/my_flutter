import 'dart:async';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter/src/models/product_response.dart';
import 'package:my_flutter/src/pages/home/widgets/image_button.dart';
import 'package:my_flutter/src/services/network_service.dart';

class CreateProduct extends StatefulWidget {
  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final spacingInput = 8.0;
  File _imageFile;

  final _form = GlobalKey<FormState>();

  ProductResponse productResponse;

  final StreamController<bool> resetImageStreamController = StreamController();

  @override
  void initState() {
    productResponse = ProductResponse();
    super.initState();
  }

  @override
  void dispose() {
    resetImageStreamController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildProductName(),
                      SizedBox(height: spacingInput),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: _buildProductPrice(),
                            flex: 1,
                          ),
                          SizedBox(width: spacingInput),
                          Flexible(
                            child: _buildProductStock(),
                            flex: 1,
                          )
                        ],
                      ),
                      SizedBox(height: 2),
                      ImageButton(callBack, resetImageStreamController),
                      SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  InputDecoration inputStyle({String label}) => InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        labelText: label,
      );

  TextFormField _buildProductName() => TextFormField(
        decoration: inputStyle(label: "name"),
        onSaved: (String value) {
          productResponse.name = value;
        },
      );

  TextFormField _buildProductPrice() => TextFormField(
        decoration: inputStyle(label: "price"),
        keyboardType: TextInputType.number,
        onSaved: (String value) {
          if (value.isEmpty) {
            productResponse.price = 0;
          } else {
            productResponse.price = int.parse(value);
          }
        },
      );

  TextFormField _buildProductStock() => TextFormField(
        decoration: inputStyle(label: "stock"),
        keyboardType: TextInputType.number,
        onSaved: (String value) {
          if (value.isEmpty) {
            productResponse.stock = 0;
          } else {
            productResponse.stock = int.parse(value);
          }
        },
      );

  _buildSubmitButton() => Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text("submit"),
            onPressed: () {
              _form.currentState.save();
              addProduct();
            },
          ),
        ),
      );

  callBack(File imageFile) {
    _imageFile = imageFile;
  }

  void addProduct() {
    NetworkService().addProduct(_imageFile, productResponse).then((value) {
      if (value.isEmpty) {
        showAlertBar(
          message: "upload failure",
          icon: Icons.close,
          color: Colors.red,
        );
      } else {
        showAlertBar(
          message: value,
        );
        _form.currentState.reset();
        resetImageStreamController.add(true);
      }
    });
  }

  void showAlertBar({
    String message,
    IconData icon = FontAwesomeIcons.checkCircle,
    MaterialColor color = Colors.green,
  }) {
    Flushbar(
      message: message,
      icon: Icon(
        icon,
        size: 28.0,
        color: color,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }
}
