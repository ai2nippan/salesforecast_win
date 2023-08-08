import 'dart:convert';

class SalesTargetHeadModel {
  final String DOCNO;
  final String DATEDOC;
  final String SALEID;
  final String ZID;
  final String XYEAR;
  SalesTargetHeadModel({
    required this.DOCNO,
    required this.DATEDOC,
    required this.SALEID,
    required this.ZID,
    required this.XYEAR,
  });

  SalesTargetHeadModel copyWith({
    String? DOCNO,
    String? DATEDOC,
    String? SALEID,
    String? ZID,
    String? XYEAR,
  }) {
    return SalesTargetHeadModel(
      DOCNO: DOCNO ?? this.DOCNO,
      DATEDOC: DATEDOC ?? this.DATEDOC,
      SALEID: SALEID ?? this.SALEID,
      ZID: ZID ?? this.ZID,
      XYEAR: XYEAR ?? this.XYEAR,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'DOCNO': DOCNO,
      'DATEDOC': DATEDOC,
      'SALEID': SALEID,
      'ZID': ZID,
      'XYEAR': XYEAR,
    };
  }

  factory SalesTargetHeadModel.fromMap(Map<String, dynamic> map) {
    return SalesTargetHeadModel(
      DOCNO: map['DOCNO'] ?? '',
      DATEDOC: map['DATEDOC'] ?? '',
      SALEID: map['SALEID'] ?? '',
      ZID: map['ZID'] ?? '',
      XYEAR: map['XYEAR'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesTargetHeadModel.fromJson(String source) => SalesTargetHeadModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SalesTargetHeadModel(DOCNO: $DOCNO, DATEDOC: $DATEDOC, SALEID: $SALEID, ZID: $ZID, XYEAR: $XYEAR)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SalesTargetHeadModel &&
      other.DOCNO == DOCNO &&
      other.DATEDOC == DATEDOC &&
      other.SALEID == SALEID &&
      other.ZID == ZID &&
      other.XYEAR == XYEAR;
  }

  @override
  int get hashCode {
    return DOCNO.hashCode ^
      DATEDOC.hashCode ^
      SALEID.hashCode ^
      ZID.hashCode ^
      XYEAR.hashCode;
  }
}
