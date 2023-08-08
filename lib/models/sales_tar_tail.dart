import 'dart:convert';

class SalesTargetTailModel {
  final String DOCNO;
  final String LINE;
  final String MONTH;
  final String TARGET;
  final String ACTUAL;
  final String DIFF;
  final String QLINE;
  SalesTargetTailModel({
    required this.DOCNO,
    required this.LINE,
    required this.MONTH,
    required this.TARGET,
    required this.ACTUAL,
    required this.DIFF,
    required this.QLINE,
  });

  SalesTargetTailModel copyWith({
    String? DOCNO,
    String? LINE,
    String? MONTH,
    String? TARGET,
    String? ACTUAL,
    String? DIFF,
    String? QLINE,
  }) {
    return SalesTargetTailModel(
      DOCNO: DOCNO ?? this.DOCNO,
      LINE: LINE ?? this.LINE,
      MONTH: MONTH ?? this.MONTH,
      TARGET: TARGET ?? this.TARGET,
      ACTUAL: ACTUAL ?? this.ACTUAL,
      DIFF: DIFF ?? this.DIFF,
      QLINE: QLINE ?? this.QLINE,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'DOCNO': DOCNO,
      'LINE': LINE,
      'MONTH': MONTH,
      'TARGET': TARGET,
      'ACTUAL': ACTUAL,
      'DIFF': DIFF,
      'QLINE': QLINE,
    };
  }

  factory SalesTargetTailModel.fromMap(Map<String, dynamic> map) {
    return SalesTargetTailModel(
      DOCNO: map['DOCNO'] ?? '',
      LINE: map['LINE'] ?? '',
      MONTH: map['MONTH'] ?? '',
      TARGET: map['TARGET'] ?? '',
      ACTUAL: map['ACTUAL'] ?? '',
      DIFF: map['DIFF'] ?? '',
      QLINE: map['QLINE'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesTargetTailModel.fromJson(String source) => SalesTargetTailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SalesTargetTailModel(DOCNO: $DOCNO, LINE: $LINE, MONTH: $MONTH, TARGET: $TARGET, ACTUAL: $ACTUAL, DIFF: $DIFF, QLINE: $QLINE)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SalesTargetTailModel &&
      other.DOCNO == DOCNO &&
      other.LINE == LINE &&
      other.MONTH == MONTH &&
      other.TARGET == TARGET &&
      other.ACTUAL == ACTUAL &&
      other.DIFF == DIFF &&
      other.QLINE == QLINE;
  }

  @override
  int get hashCode {
    return DOCNO.hashCode ^
      LINE.hashCode ^
      MONTH.hashCode ^
      TARGET.hashCode ^
      ACTUAL.hashCode ^
      DIFF.hashCode ^
      QLINE.hashCode;
  }
}
