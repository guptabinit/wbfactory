import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String title;
  final String name;
  final String street;
  final String city;
  final String country;
  final String zip;
  final String phone;
  final double latitude;
  final double longitude;

  Address({
    required this.title,
    required this.name,
    required this.street,
    required this.city,
    required this.country,
    required this.zip,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
    'title' : title,
    'name' : name,
    'street' : street,
    'city' : city,
    'country' : country,
    'zip' : zip,
    'phone' : phone,
    'latitude' : latitude,
    'longitude' : longitude,
  };

  static Address fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Address(
      title: snapshot['title'],
      name: snapshot['name'],
      street: snapshot['street'],
      city: snapshot['city'],
      country: snapshot['country'],
      zip: snapshot['zip'],
      phone: snapshot['phone'],
      latitude: snapshot['latitude'],
      longitude: snapshot['longitude'],
    );
  }
}
