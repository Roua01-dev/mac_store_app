import 'dart:convert';

class User {
  //define fields
  final String id;
  final String fullname;
  final String email;
  final String password;
  final String state;
  final String city;
  final String locality;
  final String token;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.state,
    required this.city,
    required this.locality,
    required this.token
  });
  //serialization:covert user oject to a map
  //Map:collection o key-value pairs
  //why :coverting to a map is an intermediate step that makes it easier to serialize
  //that object to formates like json for storage or transmission
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

  //serialization:covert Map  to a Json string
  //this method directly encode the data from the map into a json string
  String toJson() {
    return json.encode(toMap());
  }

  // Deserialization: Covert a Map to a User Object
  // purpose - Manipulation and user : Once the data is coverted a to a User object
  // it can be easily manipulated and use within the application . For example
  // we might want to display the user's fullName, email etc on the Ui. or we might
  // want to save the data locally.

  // the factory contructor takes a Map(Usually obtained from a Json object)
  /// and coverts it into a User Obeject.if a field is not presend in the ,
  /// it defaults to an empty String.
  // yesa3ml factory class hedhy lel flutter traja3 json l object bch tnajm testa3mlo
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String? ?? "",
      fullname: map['fullname'] as String? ?? "",
      email: map['email'] as String? ?? "",
      password: map['password'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      token: map['token'] as String? ?? "",
      
    );
  }

  //fromJson: this factroy constructor tales jso string and decodes into a map<String, dynamic>
  // and then uses the fromMap constructor to create a user object
  factory User.fromJson(String jsonString) {
    Map<String, dynamic> map = json.decode(jsonString);
    return User.fromMap(map);
  }
}
