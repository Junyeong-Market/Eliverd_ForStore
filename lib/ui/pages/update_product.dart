import 'dart:ui';

import 'package:Eliverd/common/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import 'package:Eliverd/ui/widgets/header.dart';
import 'package:Eliverd/common/string.dart';

// TO-DO: Camera 인터페이스 구현 후 정의하도록 하기
// import 'package:camera/camera.dart';

class UpdateProductPage extends StatefulWidget {
  // TO-DO: Product 개체를 필드로 변경
  const UpdateProductPage({Key key, this.name, this.price, this.manufacturer}) : super(key: key);

  final String name;
  final int price;
  final String manufacturer;

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  // TO-DO: Camera 인터페이스 구현 후 선언하도록 하기
  // CameraController _controller;
  // Future<void> _initializeControllerFuture;

  // TO-DO: Controller를 UpdateProductPage에서 가져온 Product 개체 내용으로 화모두 초기
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _manufacturerController = TextEditingController();

  // TO-DO: Camera 인터페이스 구현 후 선언하도록 하기
  // bool isCameraReady = false;
  // bool showCapturedPhoto = false;
  // TO-DO: Camera 인터페이스 구현 후 false로 변경
  bool isBarcodeAdded = false;
  bool isLastPage = false;

  String get currency => NumberFormat.compactSimpleCurrency(locale: 'ko').currencySymbol;

  // TO-DO: Camera 인터페이스 구현 후 정의하도록 하기
  /*
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final selectedCamera = cameras.first;

    _controller = CameraController(selectedCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();

    if (!mounted) {
      return;
    }

    setState(() {
      isCameraReady = true;
    });
  }
  */

  void _stateToBarcodeAdded() {
    setState(() {
      isBarcodeAdded = true;
    });
  }

  void _stateToLastPage(text) {
    if (text.length != 0) {
      setState(() {
        isLastPage = true;
      });
    }
  }

  void _submitProduct() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // TO-DO: Camera 인터페이스 구현 후 호출하도록 하기
    // initializeCamera();
  }

  @override
  void dispose() {
    // TO-DO: Camera 인터페이스 구현 후 호출하도록 하기
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: Key('UpdateProductPage'),
      appBar: Header(
        height: height / 4.8,
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: eliverdColor,
              elevation: 0.0,
            ),
            Align(
              alignment: FractionalOffset(0.1, 0.0),
              child: Text(
                TitleStrings.updateProductTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: height / 30.0),
          Visibility(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                ProductStrings.barcodeDescWhenUpdate,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 28.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            maintainSize: false,
            maintainAnimation: true,
            maintainState: true,
            visible: !isBarcodeAdded,
          ),
          // TO-DO: CameraPreview 위젯을 추가하여 바코드 인식이 되도록 하기
          Visibility(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      isBarcodeAdded ? ProductStrings.noBarcodeDesc : ProductStrings.barcodeDesc,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: true,
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _nameController.text.length != 0 ? ProductStrings.nameDesc : ProductStrings.nameDescWhenUpdate,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 28.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          controller: _nameController,
                          enabled: _nameController.text.length == 0,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: isBarcodeAdded,
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _priceController.text.length != 0 ? ProductStrings.priceDesc : ProductStrings.priceDescWhenUpdate,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 28.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          controller: _priceController,
                          enabled: _priceController.text.length == 0,
                          keyboardType: TextInputType.numberWithOptions(),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                            prefixText: currency,
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _nameController.text.length != 0,
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _manufacturerController.text.length != 0 ? ProductStrings.manufacturerDesc : ProductStrings.manufacturerDescWhenUpdate,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 28.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          controller: _manufacturerController,
                          enabled: _manufacturerController.text.length == 0,
                          onSubmitted: _stateToLastPage,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _priceController.text.length != 0,
                ),
              ],
            ),
            maintainSize: false,
            maintainAnimation: true,
            maintainState: true,
            visible: isBarcodeAdded,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: CupertinoButton(
            color: eliverdColor,
            disabledColor: Colors.black12,
            child: Text(
              isBarcodeAdded ? ProductStrings.submit : ProductStrings.next,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            onPressed: isBarcodeAdded ? (isLastPage ? _submitProduct : null) : _stateToBarcodeAdded,
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedPrice = newValue.text.replaceAll(',', '');

    int price = int.parse(formattedPrice);

    String newText = NumberFormat.currency(
      locale: 'ko',
      symbol: '',
    ).format(price);

    return newValue.copyWith(
      text: newText,
      selection: new TextSelection.collapsed(offset: newText.length)
    );
  }
}
