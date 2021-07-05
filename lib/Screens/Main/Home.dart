import 'package:centic_bids/ChangeNotifiers/FirebaseData.dart';
import 'package:centic_bids/Controllers/Authentication.dart';
import 'package:centic_bids/Models/Item.dart';
import 'package:centic_bids/Screens/Auth/Login.dart';
import 'package:centic_bids/Screens/Main/ItemDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var loggedIn = FirebaseAuth.instance.currentUser;

  List<Widget> itemsList = [];

  Future<List<Item>> itemFuture;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _itemBuilder(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Items"),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              if (loggedIn != null) {
                AuthService().logout(context);
              } else {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Login(),
                  ),
                );
              }
            },
            child: Text(loggedIn != null ? 'Logout' : 'Login',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
        ),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context) {
    return Consumer<FirebaseData>(
      builder: (_, firebase, w) {
        var dataList = firebase.itemList;
        return ListView.separated(
            itemCount: dataList.length,
            shrinkWrap: true,
            separatorBuilder: (_, i) {
              return Divider();
            },
            itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Image(
                          image: NetworkImage(dataList[i].itemImg),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                        child: Row(
                          children: [
                            Text(
                              dataList[i].title.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '\$${dataList[i].basePrice.toString()}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            dataList[i].description.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "LatestBid",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '\$${dataList[i].latestBid.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  "Remaining",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "10hrs & 20mints",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ItemDetails(dataList[i].id)),
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          child: Text(
                            'Bid Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
