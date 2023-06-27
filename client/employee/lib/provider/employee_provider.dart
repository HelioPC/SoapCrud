import 'package:employee/constants/urls.dart';
import 'package:employee/model/employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class EmployeeProvider extends ChangeNotifier {
  Employee? _searchedEmployee;

  Employee? get searchedEmployee => _searchedEmployee;

  Future<void> getEmployeeById(int id) async {
    String body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:com="http://com.springbootsoap.allapis">
  <soapenv:Header/>
   <soapenv:Body>
      <com:getEmployeeByIdRequest>
         <com:employeeId>$id</com:employeeId>
      </com:getEmployeeByIdRequest>
   </soapenv:Body>
</soapenv:Envelope>
''';

    try {
      var response = await http.post(
        Uri.parse(SOAPBASEURL),
        headers: {
          'Content-Type': 'text/xml;charset=utf-8',
          'SOAPACTION': '',
        },
        body: body,
      );

      if (response.statusCode < 300 && response.statusCode >= 200) {
        var items = xml.XmlDocument.parse(response.body);

        _searchedEmployee = Employee(
          id: int.parse(items.findAllElements(SOAPID).first.innerText),
          name: items.findAllElements(SOAPNAME).first.innerText,
          phone: items.findAllElements(SOAPPHONE).first.innerText,
          department: items.findAllElements(SOAPDEPARTMENT).first.innerText,
          address: items.findAllElements(SOAPADDRESS).first.innerText,
        );
      }
    } catch (e) {
      print("Ocorreu um erro inesperado");
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> addEmployee(Employee employee) {
    // TODO: Implement add employee
    return Future.delayed(const Duration(seconds: 3));
  }

  Future<void> updateEmployee(Employee employee) {
    // TODO: Implement update employee
    return Future.delayed(const Duration(seconds: 3));
  }

  Future<void> deleteEmployee(Employee employee) {
    // TODO: Implement delete employee
    return Future.delayed(const Duration(seconds: 3));
  }
}
