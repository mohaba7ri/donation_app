import 'package:cloud_firestore/cloud_firestore.dart';

final userDB = FirebaseFirestore.instance.collection('Users');
final transactionOrderDB = FirebaseFirestore.instance.collection('TransactionOrder');

final systemWalletAddressDB = FirebaseFirestore.instance.collection('SystemWalletAddress');

final notificationDB = FirebaseFirestore.instance.collection('Notifications');
final customerServiceDB = FirebaseFirestore.instance.collection('CustomerService');

CollectionReference userFinancialDB(String userID) {
  return FirebaseFirestore.instance.collection('Users').doc(userID).collection("userFinancialDB");
}


DocumentReference<Map<String, dynamic>> userQuantifyingDB(String userID) {
  return FirebaseFirestore.instance.collection('Users').doc(userID).collection("quantifyingDB").doc("Quantifying");
}