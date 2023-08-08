import 'dart:convert';

class SalesTargetModel {
  final String SID;
  final String SNAME;
  final String YEAR;
  final String MONTH;
  final String TARGET;
  final String ACTUAL;
  SalesTargetModel({
    required this.SID,
    required this.SNAME,
    required this.YEAR,
    required this.MONTH,
    required this.TARGET,
    required this.ACTUAL,
  });

  SalesTargetModel copyWith({
    String? SID,
    String? SNAME,
    String? YEAR,
    String? MONTH,
    String? TARGET,
    String? ACTUAL,
  }) {
    return SalesTargetModel(
      SID: SID ?? this.SID,
      SNAME: SNAME ?? this.SNAME,
      YEAR: YEAR ?? this.YEAR,
      MONTH: MONTH ?? this.MONTH,
      TARGET: TARGET ?? this.TARGET,
      ACTUAL: ACTUAL ?? this.ACTUAL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SID': SID,
      'SNAME': SNAME,
      'YEAR': YEAR,
      'MONTH': MONTH,
      'TARGET': TARGET,
      'ACTUAL': ACTUAL,
    };
  }

  factory SalesTargetModel.fromMap(Map<String, dynamic> map) {
    return SalesTargetModel(
      SID: map['SID'] ?? '',
      SNAME: map['SNAME'] ?? '',
      YEAR: map['YEAR'] ?? '',
      MONTH: map['MONTH'] ?? '',
      TARGET: map['TARGET'] ?? '',
      ACTUAL: map['ACTUAL'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesTargetModel.fromJson(String source) => SalesTargetModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SalesTargetModel(SID: $SID, SNAME: $SNAME, YEAR: $YEAR, MONTH: $MONTH, TARGET: $TARGET, ACTUAL: $ACTUAL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SalesTargetModel &&
      other.SID == SID &&
      other.SNAME == SNAME &&
      other.YEAR == YEAR &&
      other.MONTH == MONTH &&
      other.TARGET == TARGET &&
      other.ACTUAL == ACTUAL;
  }

  @override
  int get hashCode {
    return SID.hashCode ^
      SNAME.hashCode ^
      YEAR.hashCode ^
      MONTH.hashCode ^
      TARGET.hashCode ^
      ACTUAL.hashCode;
  }
}
