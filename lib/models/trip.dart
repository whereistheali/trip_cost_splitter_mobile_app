class Trip {
  final String id;
  final String fromLocation;
  final String toLocation;
  final double distance;
  final String vehicle;
  final double avgKmLitre;
  final double pkrLitre;
  final double tollParking;
  final double foodSnacks;
  final int peopleCount;
  final double totalCost;
  final double perPerson;
  final double fuelCost;
  final DateTime createdAt;

  Trip({
    required this.id,
    required this.fromLocation,
    required this.toLocation,
    required this.distance,
    required this.vehicle,
    required this.avgKmLitre,
    required this.pkrLitre,
    required this.tollParking,
    required this.foodSnacks,
    required this.peopleCount,
    required this.totalCost,
    required this.perPerson,
    required this.fuelCost,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'distance': distance,
      'vehicle': vehicle,
      'avgKmLitre': avgKmLitre,
      'pkrLitre': pkrLitre,
      'tollParking': tollParking,
      'foodSnacks': foodSnacks,
      'peopleCount': peopleCount,
      'totalCost': totalCost,
      'perPerson': perPerson,
      'fuelCost': fuelCost,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as String,
      fromLocation: json['fromLocation'] as String,
      toLocation: json['toLocation'] as String,
      distance: (json['distance'] as num).toDouble(),
      vehicle: json['vehicle'] as String,
      avgKmLitre: (json['avgKmLitre'] as num).toDouble(),
      pkrLitre: (json['pkrLitre'] as num).toDouble(),
      tollParking: (json['tollParking'] as num).toDouble(),
      foodSnacks: (json['foodSnacks'] as num).toDouble(),
      peopleCount: json['peopleCount'] as int,
      totalCost: (json['totalCost'] as num).toDouble(),
      perPerson: (json['perPerson'] as num).toDouble(),
      fuelCost: (json['fuelCost'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
