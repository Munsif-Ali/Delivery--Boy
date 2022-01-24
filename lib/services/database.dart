import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServie {
  late String? uId;
  DatabaseServie({
    this.uId,
  });
  static final CollectionReference deliveryBoys =
      FirebaseFirestore.instance.collection("deliveryBoy");

  Future updateUserData(String name, String phone, String city) async {
    return await deliveryBoys.doc(uId).set({
      "name": name,
      "phone": phone,
      "city": city,
    });
  }
 Stream<QuerySnapshot> get delivboy {
    return deliveryBoys.snapshots();
  }
}
