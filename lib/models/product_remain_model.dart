import 'dart:convert';

// ถามยอดคงเหลือสินค้า + B/o (oe)
// Script
/*
SELECT invmst.XSGROUP,invmst.XIDTYPE,
id,xdesc,nbal,invmst.UNIT, invmst.BACKORDER
FROM invmst 
where xsgroup = 'XXX' and xidtype = 'XXX';
*/

class ProductRemainBOModel {
  final String XSGROUP;
  final String XIDTYPE;
  final String ID;
  final String XDESC;
  final String NBAL;
  final String UNIT;
  final String BACKORDER;
  ProductRemainBOModel({
    required this.XSGROUP,
    required this.XIDTYPE,
    required this.ID,
    required this.XDESC,
    required this.NBAL,
    required this.UNIT,
    required this.BACKORDER,
  });
  

  ProductRemainBOModel copyWith({
    String? XSGROUP,
    String? XIDTYPE,
    String? ID,
    String? XDESC,
    String? NBAL,
    String? UNIT,
    String? BACKORDER,
  }) {
    return ProductRemainBOModel(
      XSGROUP: XSGROUP ?? this.XSGROUP,
      XIDTYPE: XIDTYPE ?? this.XIDTYPE,
      ID: ID ?? this.ID,
      XDESC: XDESC ?? this.XDESC,
      NBAL: NBAL ?? this.NBAL,
      UNIT: UNIT ?? this.UNIT,
      BACKORDER: BACKORDER ?? this.BACKORDER,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'XSGROUP': XSGROUP,
      'XIDTYPE': XIDTYPE,
      'ID': ID,
      'XDESC': XDESC,
      'NBAL': NBAL,
      'UNIT': UNIT,
      'BACKORDER': BACKORDER,
    };
  }

  factory ProductRemainBOModel.fromMap(Map<String, dynamic> map) {
    return ProductRemainBOModel(
      XSGROUP: map['XSGROUP'] ?? '',
      XIDTYPE: map['XIDTYPE'] ?? '',
      ID: map['ID'] ?? '',
      XDESC: map['XDESC'] ?? '',
      NBAL: map['NBAL'] ?? '',
      UNIT: map['UNIT'] ?? '',
      BACKORDER: map['BACKORDER'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductRemainBOModel.fromJson(String source) => ProductRemainBOModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductRemainBOModel(XSGROUP: $XSGROUP, XIDTYPE: $XIDTYPE, ID: $ID, XDESC: $XDESC, NBAL: $NBAL, UNIT: $UNIT, BACKORDER: $BACKORDER)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductRemainBOModel &&
      other.XSGROUP == XSGROUP &&
      other.XIDTYPE == XIDTYPE &&
      other.ID == ID &&
      other.XDESC == XDESC &&
      other.NBAL == NBAL &&
      other.UNIT == UNIT &&
      other.BACKORDER == BACKORDER;
  }

  @override
  int get hashCode {
    return XSGROUP.hashCode ^
      XIDTYPE.hashCode ^
      ID.hashCode ^
      XDESC.hashCode ^
      NBAL.hashCode ^
      UNIT.hashCode ^
      BACKORDER.hashCode;
  }
}
