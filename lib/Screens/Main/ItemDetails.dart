import 'package:centic_bids/ChangeNotifiers/FirebaseData.dart';
import 'package:centic_bids/Models/Item.dart';
import 'package:centic_bids/Utilities/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatefulWidget {
  final Item value;
  final String id;

  ItemDetails(
    this.id, {
    Key key,
    this.value,
  }) : super(key: key);
  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  String codeDialog;
  String valueText;

  TextEditingController _bidPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<FirebaseData>(context, listen: false);
    var item = data.itemList.where((element) => element.id == widget.id).first;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title.toString()),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: _buildBody(),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: () async {
            if (FirebaseAuth.instance.currentUser != null) {
              _biddingAlert(context);
            } else {
              final action = await Dialogs.alertDialog(
                  context, "Alert", "Please Login/Signup to continue", "Ok");
              if (action == alertDialogAction.cancel) {
                Navigator.pop(context);
              }
            }
          },
          child: Text(
            'Bid Now',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    var data = Provider.of<FirebaseData>(context, listen: false);
    var item = data.itemList.where((element) => element.id == widget.id).first;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Image(
                image: NetworkImage(item.itemImg),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item.title.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      Spacer(),
                      Text(
                        '\$${item.basePrice.toString()}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Consumer<FirebaseData>(builder: (_, data, widge) {
                        var ltstBid = data.getBid(widget.id);
                        return Text(
                            'Latest Bid \$${ltstBid.latestBid.toString()}');
                      }),
                      Spacer(),
                      Text("Ends in 1hr n 30mints"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(item.description.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _biddingAlert(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bid your price'),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _bidPriceController,
              decoration: InputDecoration(hintText: "numbers only"),
            ),
            actions: [
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    if (_bidPriceController.text.isNotEmpty) {
                      codeDialog = valueText;
                      placeBid();
                      Provider.of<FirebaseData>(context, listen: false)
                          .getItemList();
                      Navigator.pop(context);
                      _bidPriceController.text = "";
                    }
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _errorAlert(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Please signup to continue'),
            actions: [
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> placeBid() async {
    var data = Provider.of<FirebaseData>(context, listen: false);
    var item = data.itemList.where((element) => element.id == widget.id).first;
    await FirebaseFirestore.instance.collection('Items').doc(item.id).update(
        {"latestBid": _bidPriceController.text.toString()}).catchError((e) {
      print(e);
    });
  }
}
