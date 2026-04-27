class ReviewModel {
  final String id, productId, userName, comment;
  final double rating;
  final DateTime date;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id, 'productId': productId, 'userName': userName,
    'comment': comment, 'rating': rating, 'date': date.toIso8601String(),
  };
}
