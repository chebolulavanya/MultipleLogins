

class ProfileModel {
  MyDetails myAccountDetails;

  //  VehicleDetails details;
  ProfileModel({this.myAccountDetails});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        myAccountDetails: json['accountDetails'] != null
            ? new MyDetails.fromJson(json['accountDetails'])
            : null);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['accountDetails'] = myAccountDetails;
    return map;
  }
}

class MyDetails {
  String accountNumber;
  String connectionCode;
  String csoRequestEmail;
  String firstName;
  String lastName;
  String phoneNumber;

  MyDetails(
      {this.accountNumber,
      this.connectionCode,
      this.csoRequestEmail,
      this.firstName,
      this.lastName,
      this.phoneNumber,});
  MyDetails.fromJson(Map<String, dynamic> json) {
    accountNumber =
        json['accountNumber'] != null ? json['accountNumber'] : 'N/A';
    connectionCode =
        json['connectionCode'] != null ? json['connectionCode'] : 'N/A';
    csoRequestEmail =
        json['csoRequestemail'] != null ? json['csoRequestemail'] : 'N/A';
    firstName = json['firstName'] != null && json['firstName'] != ''? json['firstName'] : 'N/A';
    lastName = json['lastName'] != null && json['lastName'] != '' ? json['lastName'] : 'N/A';
    phoneNumber = json['phoneNumber'] != null ? json['phoneNumber'] : 'N/A';
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map['accountNumber'] = accountNumber;
    map['connectionCode'] = connectionCode;
    map['csoRequestemail'] = csoRequestEmail;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['phoneNumber'] = phoneNumber;
    return map;
  }
}

