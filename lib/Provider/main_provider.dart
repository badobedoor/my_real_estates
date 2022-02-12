import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: prefer_mixin
class MainProvider with ChangeNotifier {
  final String key = 'theme';
  List<XFile>? imageFileList = [];
  List<String> imageList = [];
  bool showReservationRequestDilog = false;
  bool filterBottomSheetIsOpen = false;
  bool filterBottomSheetDropdownlistIsOpen = false;
  // late bool _darkTheme;
  bool isLoding = false;
  bool sellansRentOrderShowBTN = false;
  bool iamReadySellShowDilog = false;
  String unitNumber = '';
  String sellRequestDocumentId = '';
  Stream<QuerySnapshot<Map<String, dynamic>>> searchResult = FirebaseFirestore
      .instance
      .collection('sellRequest')
      .where('orderStatus', whereIn: ['مقبول', 'محجوز']).snapshots();
  bool fristTimeprivacy = true;
  Future<void> changeFristTimeprivacy(bool? newfristTimeprivacy) async {
    if (fristTimeprivacy != null) {
      fristTimeprivacy = newfristTimeprivacy!;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('fristTimeprivacy', fristTimeprivacy);
      notifyListeners();
    }
  }

  Future<bool> getFristTimeprivacy() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? res = prefs.getBool('fristTimeprivacy');
    if (res != null) {
      fristTimeprivacy = res;
      notifyListeners();
      return res;
    } else {
      notifyListeners();
      return fristTimeprivacy;
    }
  }

  bool fristTime = true;

  Future<void> changeFristTime(bool? newfristTime) async {
    if (newfristTime != null) {
      fristTime = newfristTime;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('fristTime', fristTime);
      notifyListeners();
    }
  }

  Future<bool> getFristTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? res = prefs.getBool('fristTime');
    if (res != null) {
      fristTime = res;
      notifyListeners();
      return res;
    } else {
      notifyListeners();
      return fristTime;
    }
  }

  void changeiamReadySellShowDilog(bool newiamReadySellShowDilog) {
    iamReadySellShowDilog = newiamReadySellShowDilog;
    notifyListeners();
  }

  void changesellansRentOrderShowBTN(bool newsellansRentOrderShowBTN) {
    sellansRentOrderShowBTN = newsellansRentOrderShowBTN;
    notifyListeners();
  }

  void changeisLoding(bool newisLoding) {
    isLoding = newisLoding;
    notifyListeners();
  }

  void changeFilterBottomSheetIsOpen(bool newfilterBottomSheetIsOpen) {
    filterBottomSheetIsOpen = newfilterBottomSheetIsOpen;
    notifyListeners();
  }

  void changeFilterBottomSheetDropdownlistIsOpen(
      bool newfilterBottomSheetDropdownlistIsOpen) {
    filterBottomSheetDropdownlistIsOpen =
        newfilterBottomSheetDropdownlistIsOpen;
    notifyListeners();
  }

  void changeSearchResult(
      Stream<QuerySnapshot<Map<String, dynamic>>> newSearchResult) {
    searchResult = newSearchResult;
    notifyListeners();
  }

  void changeSellRequestDocumentId(String newSellRequestDocumentId) {
    sellRequestDocumentId = newSellRequestDocumentId;
    notifyListeners();
  }

  void changeimageFileList(List<XFile>? newImageFileList) {
    imageFileList = newImageFileList;
    notifyListeners();
  }

  void changeimageList(List<String> newimageList) {
    imageList = newimageList;
    notifyListeners();
  }

  void clearImageList() {
    imageList = [];

    notifyListeners();
  }

  Future<void> addToImageList(String? newimage) async {
    if (newimage != null) {
      imageList.add(newimage);
    }

    notifyListeners();
  }

  void changeShowReservationRequestDilog(bool newshowReservationRequestDilog) {
    showReservationRequestDilog = newshowReservationRequestDilog;
    notifyListeners();
  }

  void changeUnitNumber(String newUnitNumber) {
    unitNumber = newUnitNumber;
    notifyListeners();
  }
}
