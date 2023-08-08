import 'dart:convert';

class UserModel {
  final String SID;
  final String SNAME;
  final String SPASS;
  final String MOBILE;
  UserModel({
    required this.SID,
    required this.SNAME,
    required this.SPASS,
    required this.MOBILE,
  });
  

  UserModel copyWith({
    String? SID,
    String? SNAME,
    String? SPASS,
    String? MOBILE,
  }) {
    return UserModel(
      SID: SID ?? this.SID,
      SNAME: SNAME ?? this.SNAME,
      SPASS: SPASS ?? this.SPASS,
      MOBILE: MOBILE ?? this.MOBILE,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SID': SID,
      'SNAME': SNAME,
      'SPASS': SPASS,
      'MOBILE': MOBILE,
    };
  }

  // Map<String, dynamic> map = {
  //   'Content-Type': 'application/json;charset=UTF-8',
  //   'Charset': 'utf-8'
  // };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      SID: map['SID'] ?? '',
      SNAME: map['SNAME'] ?? '',
      SPASS: map['SPASS'] ?? '',
      MOBILE: map['MOBILE'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(SID: $SID, SNAME: $SNAME, SPASS: $SPASS, MOBILE: $MOBILE)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.SID == SID &&
      other.SNAME == SNAME &&
      other.SPASS == SPASS &&
      other.MOBILE == MOBILE;
  }

  @override
  int get hashCode {
    return SID.hashCode ^
      SNAME.hashCode ^
      SPASS.hashCode ^
      MOBILE.hashCode;
  }
}
