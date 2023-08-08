import 'dart:convert';

// แสดงเอกสารที่ค้างส่ง
// Script 
/*
SELECT xorder.docno,xorder.datedoc,armst.XCOMP,
(xorder.QUAN - xorder.REC) AS remain,
xorder.UNIT_SAL
FROM xorder INNER JOIN ordhead ON xorder.DOCNO = ordhead.DOCNO
INNER JOIN armst ON ordhead.ACCID = armst.ACCID
WHERE xorder.id = '0010080314014' AND quan-rec  > 0;
*/

class DocSendPendingModel {
  final String DOCNO;
  final String DATEDOC;
  final String XCOMP;
  final String REMAIN;
  final String UNIT_SAL;
  DocSendPendingModel({
    required this.DOCNO,
    required this.DATEDOC,
    required this.XCOMP,
    required this.REMAIN,
    required this.UNIT_SAL,
  });
  

  DocSendPendingModel copyWith({
    String? DOCNO,
    String? DATEDOC,
    String? XCOMP,
    String? REMAIN,
    String? UNIT_SAL,
  }) {
    return DocSendPendingModel(
      DOCNO: DOCNO ?? this.DOCNO,
      DATEDOC: DATEDOC ?? this.DATEDOC,
      XCOMP: XCOMP ?? this.XCOMP,
      REMAIN: REMAIN ?? this.REMAIN,
      UNIT_SAL: UNIT_SAL ?? this.UNIT_SAL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'DOCNO': DOCNO,
      'DATEDOC': DATEDOC,
      'XCOMP': XCOMP,
      'REMAIN': REMAIN,
      'UNIT_SAL': UNIT_SAL,
    };
  }

  factory DocSendPendingModel.fromMap(Map<String, dynamic> map) {
    return DocSendPendingModel(
      DOCNO: map['DOCNO'] ?? '',
      DATEDOC: map['DATEDOC'] ?? '',
      XCOMP: map['XCOMP'] ?? '',
      REMAIN: map['REMAIN'] ?? '',
      UNIT_SAL: map['UNIT_SAL'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DocSendPendingModel.fromJson(String source) => DocSendPendingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DocSendPendingModel(DOCNO: $DOCNO, DATEDOC: $DATEDOC, XCOMP: $XCOMP, REMAIN: $REMAIN, UNIT_SAL: $UNIT_SAL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DocSendPendingModel &&
      other.DOCNO == DOCNO &&
      other.DATEDOC == DATEDOC &&
      other.XCOMP == XCOMP &&
      other.REMAIN == REMAIN &&
      other.UNIT_SAL == UNIT_SAL;
  }

  @override
  int get hashCode {
    return DOCNO.hashCode ^
      DATEDOC.hashCode ^
      XCOMP.hashCode ^
      REMAIN.hashCode ^
      UNIT_SAL.hashCode;
  }
}
