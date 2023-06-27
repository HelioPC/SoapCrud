import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  final int id;
  final String name;
  final String phone;
  final String department;
  final String address;

  Employee({
    required this.id,
    required this.name,
    required this.phone,
    required this.department,
    required this.address,
  });

  Employee copyWith({
    int? id,
    String? name,
    String? phone,
    String? department,
    String? address,
  }) =>
      Employee(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        department: department ?? this.department,
        address: address ?? this.address,
      );

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        department: json["department"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "department": department,
        "address": address,
      };
}
