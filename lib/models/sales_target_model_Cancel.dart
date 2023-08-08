import 'dart:convert';

class SalesTargetModel {
  final String SID;
  final String SNAME;
  final String M01;
  final String M02;
  final String M03;
  final String M04;
  final String M05;
  final String M06;
  final String M07;
  final String M08;
  final String M09;
  final String M10;
  final String M11;
  final String M12;
  final String T01;
  final String T02;
  final String T03;
  final String T04;
  final String T05;
  final String T06;
  final String T07;
  final String T08;
  final String T09;
  final String T10;
  final String T11;
  final String T12;
  final String ACT01;
  final String ACT02;
  final String ACT03;
  final String ACT04;
  final String ACT05;
  final String ACT06;
  final String ACT07;
  final String ACT08;
  final String ACT09;
  final String ACT10;
  final String ACT11;
  final String ACT12;
  SalesTargetModel({
    required this.SID,
    required this.SNAME,
    required this.M01,
    required this.M02,
    required this.M03,
    required this.M04,
    required this.M05,
    required this.M06,
    required this.M07,
    required this.M08,
    required this.M09,
    required this.M10,
    required this.M11,
    required this.M12,
    required this.T01,
    required this.T02,
    required this.T03,
    required this.T04,
    required this.T05,
    required this.T06,
    required this.T07,
    required this.T08,
    required this.T09,
    required this.T10,
    required this.T11,
    required this.T12,
    required this.ACT01,
    required this.ACT02,
    required this.ACT03,
    required this.ACT04,
    required this.ACT05,
    required this.ACT06,
    required this.ACT07,
    required this.ACT08,
    required this.ACT09,
    required this.ACT10,
    required this.ACT11,
    required this.ACT12,
  });

  SalesTargetModel copyWith({
    String? SID,
    String? SNAME,
    String? M01,
    String? M02,
    String? M03,
    String? M04,
    String? M05,
    String? M06,
    String? M07,
    String? M08,
    String? M09,
    String? M10,
    String? M11,
    String? M12,
    String? T01,
    String? T02,
    String? T03,
    String? T04,
    String? T05,
    String? T06,
    String? T07,
    String? T08,
    String? T09,
    String? T10,
    String? T11,
    String? T12,
    String? ACT01,
    String? ACT02,
    String? ACT03,
    String? ACT04,
    String? ACT05,
    String? ACT06,
    String? ACT07,
    String? ACT08,
    String? ACT09,
    String? ACT10,
    String? ACT11,
    String? ACT12,
  }) {
    return SalesTargetModel(
      SID: SID ?? this.SID,
      SNAME: SNAME ?? this.SNAME,
      M01: M01 ?? this.M01,
      M02: M02 ?? this.M02,
      M03: M03 ?? this.M03,
      M04: M04 ?? this.M04,
      M05: M05 ?? this.M05,
      M06: M06 ?? this.M06,
      M07: M07 ?? this.M07,
      M08: M08 ?? this.M08,
      M09: M09 ?? this.M09,
      M10: M10 ?? this.M10,
      M11: M11 ?? this.M11,
      M12: M12 ?? this.M12,
      T01: T01 ?? this.T01,
      T02: T02 ?? this.T02,
      T03: T03 ?? this.T03,
      T04: T04 ?? this.T04,
      T05: T05 ?? this.T05,
      T06: T06 ?? this.T06,
      T07: T07 ?? this.T07,
      T08: T08 ?? this.T08,
      T09: T09 ?? this.T09,
      T10: T10 ?? this.T10,
      T11: T11 ?? this.T11,
      T12: T12 ?? this.T12,
      ACT01: ACT01 ?? this.ACT01,
      ACT02: ACT02 ?? this.ACT02,
      ACT03: ACT03 ?? this.ACT03,
      ACT04: ACT04 ?? this.ACT04,
      ACT05: ACT05 ?? this.ACT05,
      ACT06: ACT06 ?? this.ACT06,
      ACT07: ACT07 ?? this.ACT07,
      ACT08: ACT08 ?? this.ACT08,
      ACT09: ACT09 ?? this.ACT09,
      ACT10: ACT10 ?? this.ACT10,
      ACT11: ACT11 ?? this.ACT11,
      ACT12: ACT12 ?? this.ACT12,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SID': SID,
      'SNAME': SNAME,
      'M01': M01,
      'M02': M02,
      'M03': M03,
      'M04': M04,
      'M05': M05,
      'M06': M06,
      'M07': M07,
      'M08': M08,
      'M09': M09,
      'M10': M10,
      'M11': M11,
      'M12': M12,
      'T01': T01,
      'T02': T02,
      'T03': T03,
      'T04': T04,
      'T05': T05,
      'T06': T06,
      'T07': T07,
      'T08': T08,
      'T09': T09,
      'T10': T10,
      'T11': T11,
      'T12': T12,
      'ACT01': ACT01,
      'ACT02': ACT02,
      'ACT03': ACT03,
      'ACT04': ACT04,
      'ACT05': ACT05,
      'ACT06': ACT06,
      'ACT07': ACT07,
      'ACT08': ACT08,
      'ACT09': ACT09,
      'ACT10': ACT10,
      'ACT11': ACT11,
      'ACT12': ACT12,
    };
  }

  factory SalesTargetModel.fromMap(Map<String, dynamic> map) {
    return SalesTargetModel(
      SID: map['SID'] ?? '',
      SNAME: map['SNAME'] ?? '',
      M01: map['M01'] ?? '',
      M02: map['M02'] ?? '',
      M03: map['M03'] ?? '',
      M04: map['M04'] ?? '',
      M05: map['M05'] ?? '',
      M06: map['M06'] ?? '',
      M07: map['M07'] ?? '',
      M08: map['M08'] ?? '',
      M09: map['M09'] ?? '',
      M10: map['M10'] ?? '',
      M11: map['M11'] ?? '',
      M12: map['M12'] ?? '',
      T01: map['T01'] ?? '',
      T02: map['T02'] ?? '',
      T03: map['T03'] ?? '',
      T04: map['T04'] ?? '',
      T05: map['T05'] ?? '',
      T06: map['T06'] ?? '',
      T07: map['T07'] ?? '',
      T08: map['T08'] ?? '',
      T09: map['T09'] ?? '',
      T10: map['T10'] ?? '',
      T11: map['T11'] ?? '',
      T12: map['T12'] ?? '',
      ACT01: map['ACT01'] ?? '',
      ACT02: map['ACT02'] ?? '',
      ACT03: map['ACT03'] ?? '',
      ACT04: map['ACT04'] ?? '',
      ACT05: map['ACT05'] ?? '',
      ACT06: map['ACT06'] ?? '',
      ACT07: map['ACT07'] ?? '',
      ACT08: map['ACT08'] ?? '',
      ACT09: map['ACT09'] ?? '',
      ACT10: map['ACT10'] ?? '',
      ACT11: map['ACT11'] ?? '',
      ACT12: map['ACT12'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesTargetModel.fromJson(String source) => SalesTargetModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SalesTargetModel(SID: $SID, SNAME: $SNAME, M01: $M01, M02: $M02, M03: $M03, M04: $M04, M05: $M05, M06: $M06, M07: $M07, M08: $M08, M09: $M09, M10: $M10, M11: $M11, M12: $M12, T01: $T01, T02: $T02, T03: $T03, T04: $T04, T05: $T05, T06: $T06, T07: $T07, T08: $T08, T09: $T09, T10: $T10, T11: $T11, T12: $T12, ACT01: $ACT01, ACT02: $ACT02, ACT03: $ACT03, ACT04: $ACT04, ACT05: $ACT05, ACT06: $ACT06, ACT07: $ACT07, ACT08: $ACT08, ACT09: $ACT09, ACT10: $ACT10, ACT11: $ACT11, ACT12: $ACT12)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SalesTargetModel &&
      other.SID == SID &&
      other.SNAME == SNAME &&
      other.M01 == M01 &&
      other.M02 == M02 &&
      other.M03 == M03 &&
      other.M04 == M04 &&
      other.M05 == M05 &&
      other.M06 == M06 &&
      other.M07 == M07 &&
      other.M08 == M08 &&
      other.M09 == M09 &&
      other.M10 == M10 &&
      other.M11 == M11 &&
      other.M12 == M12 &&
      other.T01 == T01 &&
      other.T02 == T02 &&
      other.T03 == T03 &&
      other.T04 == T04 &&
      other.T05 == T05 &&
      other.T06 == T06 &&
      other.T07 == T07 &&
      other.T08 == T08 &&
      other.T09 == T09 &&
      other.T10 == T10 &&
      other.T11 == T11 &&
      other.T12 == T12 &&
      other.ACT01 == ACT01 &&
      other.ACT02 == ACT02 &&
      other.ACT03 == ACT03 &&
      other.ACT04 == ACT04 &&
      other.ACT05 == ACT05 &&
      other.ACT06 == ACT06 &&
      other.ACT07 == ACT07 &&
      other.ACT08 == ACT08 &&
      other.ACT09 == ACT09 &&
      other.ACT10 == ACT10 &&
      other.ACT11 == ACT11 &&
      other.ACT12 == ACT12;
  }

  @override
  int get hashCode {
    return SID.hashCode ^
      SNAME.hashCode ^
      M01.hashCode ^
      M02.hashCode ^
      M03.hashCode ^
      M04.hashCode ^
      M05.hashCode ^
      M06.hashCode ^
      M07.hashCode ^
      M08.hashCode ^
      M09.hashCode ^
      M10.hashCode ^
      M11.hashCode ^
      M12.hashCode ^
      T01.hashCode ^
      T02.hashCode ^
      T03.hashCode ^
      T04.hashCode ^
      T05.hashCode ^
      T06.hashCode ^
      T07.hashCode ^
      T08.hashCode ^
      T09.hashCode ^
      T10.hashCode ^
      T11.hashCode ^
      T12.hashCode ^
      ACT01.hashCode ^
      ACT02.hashCode ^
      ACT03.hashCode ^
      ACT04.hashCode ^
      ACT05.hashCode ^
      ACT06.hashCode ^
      ACT07.hashCode ^
      ACT08.hashCode ^
      ACT09.hashCode ^
      ACT10.hashCode ^
      ACT11.hashCode ^
      ACT12.hashCode;
  }
}
