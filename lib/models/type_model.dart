import 'dart:convert';

// ชนิดสินค้า (Level 2)
class ProductTypeModel {
  final String IDTID;
  final String IDTDESC;
  ProductTypeModel({
    required this.IDTID,
    required this.IDTDESC,
  });
  

  ProductTypeModel copyWith({
    String? IDTID,
    String? IDTDESC,
  }) {
    return ProductTypeModel(
      IDTID: IDTID ?? this.IDTID,
      IDTDESC: IDTDESC ?? this.IDTDESC,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'IDTID': IDTID,
      'IDTDESC': IDTDESC,
    };
  }

  factory ProductTypeModel.fromMap(Map<String, dynamic> map) {
    return ProductTypeModel(
      IDTID: map['IDTID'] ?? '',
      IDTDESC: map['IDTDESC'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductTypeModel.fromJson(String source) => ProductTypeModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProductTypeModel(IDTID: $IDTID, IDTDESC: $IDTDESC)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductTypeModel &&
      other.IDTID == IDTID &&
      other.IDTDESC == IDTDESC;
  }

  @override
  int get hashCode => IDTID.hashCode ^ IDTDESC.hashCode;
}
