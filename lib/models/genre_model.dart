import 'dart:convert';

// ประเภทสินค้า (Leve 1)
class ProductGenreModel {
  final String IVGID;
  final String IVGDESC;
  ProductGenreModel({
    required this.IVGID,
    required this.IVGDESC,
  });
  

  ProductGenreModel copyWith({
    String? IVGID,
    String? IVGDESC,
  }) {
    return ProductGenreModel(
      IVGID: IVGID ?? this.IVGID,
      IVGDESC: IVGDESC ?? this.IVGDESC,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'IVGID': IVGID,
      'IVGDESC': IVGDESC,
    };
  }

  factory ProductGenreModel.fromMap(Map<String, dynamic> map) {
    return ProductGenreModel(
      IVGID: map['IVGID'] ?? '',
      IVGDESC: map['IVGDESC'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductGenreModel.fromJson(String source) => ProductGenreModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProductGenreModel(IVGID: $IVGID, IVGDESC: $IVGDESC)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductGenreModel &&
      other.IVGID == IVGID &&
      other.IVGDESC == IVGDESC;
  }

  @override
  int get hashCode => IVGID.hashCode ^ IVGDESC.hashCode;
}

