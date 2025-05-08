class Warehouse {
  final String id;
  final String name;
  final String location;

  Warehouse({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id'].toString(),
      name: json['name'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };
  }
} 