import 'package:cloud_firestore/cloud_firestore.dart';

class VegetableModel {
  final String id;
  final String tamilName;
  final String englishName;
  final double todayPrice;
  final double yesterdayPrice;
  final String unit;
  final DateTime? updatedAt;

  VegetableModel({
    required this.id,
    required this.tamilName,
    required this.englishName,
    required this.todayPrice,
    required this.yesterdayPrice,
    this.unit = 'kg',
    this.updatedAt,
  });

  double get priceDiff => todayPrice - yesterdayPrice;
  double get priceDiffPercent =>
      yesterdayPrice > 0 ? (priceDiff / yesterdayPrice) * 100 : 0;
  bool get isPriceUp => priceDiff > 0;
  bool get isPriceDown => priceDiff < 0;
  bool get isPriceStable => priceDiff == 0;

  factory VegetableModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return VegetableModel(
      id: doc.id,
      tamilName: data['tamil_name'] ?? '',
      englishName: data['english_name'] ?? '',
      todayPrice: (data['today_price'] ?? 0).toDouble(),
      yesterdayPrice: (data['yesterday_price'] ?? 0).toDouble(),
      unit: data['unit'] ?? 'kg',
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'tamil_name': tamilName,
        'english_name': englishName,
        'today_price': todayPrice,
        'yesterday_price': yesterdayPrice,
        'unit': unit,
        'updated_at': FieldValue.serverTimestamp(),
      };
}
