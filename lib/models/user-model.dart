

class UserModel {

  String? docID;
  String? firstName;
  String? lastName;
  String? address;
  String? phoneNumber;
  String? email;
  String? password;
  String? gender;
  String? age;
  String? birthDate;
  String? userType;
  String? imageUrl;
  String? token;
  bool? isAccept;
  Map? geoLocation;


  UserModel(
      {this.docID,this.firstName,
        this.lastName,
        this.address,
        this.phoneNumber,
        this.email,
        this.password,
        this.gender,
        this.age,
        this.birthDate,
        this.userType,
        this.imageUrl,
        this.token,
        this.isAccept,
        this.geoLocation});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(

      docID: map['docID'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      password: map['fakePassword'],
      gender: map['gender'],
      age: map['age'],
      birthDate: map['birthDate'],
      userType: map['userType'],
      imageUrl: map['imageUrl'],
      token: map['token'],
      isAccept: map['isAccept'],
      geoLocation: map['geoLocation'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {

      'docID': docID,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'fakePassword': password,
      'gender': gender,
      'age': age,
      'birthDate': birthDate,
      'userType': userType,
      'imageUrl': imageUrl,
      'token': token,
      'isAccept': isAccept,
      'geoLocation': geoLocation,
    };
  }
}