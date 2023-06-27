import 'package:employee/model/employee.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Employee employee;

  const DetailPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
      ),
      body: Column(
        children: [
          CircleAvatar(
            minRadius: 50,
            child: Text(employee.name.toUpperCase()[0]),
          ),
          const SizedBox(height: 40),
          RichText(
            text: TextSpan(
              text: 'Name: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: employee.name,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Phone number: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: employee.phone,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Department: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: employee.department,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Address: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: employee.address,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
