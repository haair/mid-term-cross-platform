import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mid_term_1/models/product.dart';

class DatabaseMethods {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future addProduct(Map<String, dynamic> productInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("product")
        .doc(id)
        .set(productInfoMap);
  }

  // Future<Stream<QuerySnapshot>> getProduct() async {
  //   return FirebaseFirestore.instance.collection('product').snapshots();
  // }

  Stream<List<Product>> getData() {
    return _db
        .collection('product')
        .orderBy('id', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data());
      }).toList();
    });
  }

  Future deleteProduct(String id) {
    return _db.collection("product").doc(id).delete();
  }

  Future update(Map<String, dynamic> productInfoMap, String id) {
    return _db.collection("product").doc(id).update(productInfoMap);
  }
}
