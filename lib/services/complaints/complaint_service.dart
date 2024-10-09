import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintService {
  //instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get message

  Stream<QuerySnapshot> getcomplaints() {
    return _firestore
        .collection("Complaints")
        .doc("WEIGH BRIDGE")
        .collection("Complaints")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getcomplaints1() {
    return _firestore
        .collection("Complaints")
        .doc("WEIGHING SCALE")
        .collection("Complaints")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
