import 'package:centic_bids/Models/Item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseData extends ChangeNotifier {
  List<Item> itemList = [];

  bool isLoading = false;

  FirebaseData() {
    getItemList();
  }

  Future getItemList() async {
    isLoading = true;
    notifyListeners();
    await FirebaseFirestore.instance
        .collection("Items")
        .get()
        .then((querySnapshot) {
      itemList.clear();
      querySnapshot.docs.forEach((itemRec) {
        Map<String, dynamic> dd = itemRec.data();
        dd['id'] = itemRec.id;
        itemList.add(Item.fromJson(dd));
      });
    });
    isLoading = false;
    notifyListeners();
  }

  Item  getBid(String id){
    return itemList.where((element) => element.id == id ).first;
  } 
}
