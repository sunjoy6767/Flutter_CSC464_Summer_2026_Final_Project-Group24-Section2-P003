import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore schema — collection: "products"
///
/// products/{productId}
///   name        : string   — product name, e.g. "Wireless Mouse"
///   category    : string   — e.g. "Electronics"
///   price       : number   — unit price in BDT (e.g. 1250.0)
///   description : string   — short product description
///   imageUrl    : string   — placeholder/asset path or remote URL,
///                            e.g. "assets/images/placeholder.png"
///   stock       : number   — units currently in stock (integer)
///
/// {productId} is the Firestore-generated document ID; it is not stored
/// as a field inside the document itself.
class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection('products');

  /// Creates a new product document and returns its generated ID.
  Future<String> createProduct(Map<String, dynamic> data) async {
    final docRef = await _products.add(data);
    return docRef.id;
  }

  /// Reads a single product document by ID. Returns null if it doesn't exist.
  Future<Map<String, dynamic>?> readProduct(String productId) async {
    final snapshot = await _products.doc(productId).get();
    return snapshot.data();
  }

  /// Reads all product documents once.
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  readAllProducts() async {
    final snapshot = await _products.get();
    return snapshot.docs;
  }

  /// Updates fields on an existing product document.
  Future<void> updateProduct(String productId, Map<String, dynamic> data) {
    return _products.doc(productId).update(data);
  }

  /// Deletes a product document.
  Future<void> deleteProduct(String productId) {
    return _products.doc(productId).delete();
  }

  /// Streams live updates for the full products collection.
  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts() {
    return _products.snapshots();
  }

  /// Streams live updates for a single product document.
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProduct(
    String productId,
  ) {
    return _products.doc(productId).snapshots();
  }
}
