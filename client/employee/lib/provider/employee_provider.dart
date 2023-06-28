import 'dart:developer';

import 'package:employee/constants/urls.dart';
import 'package:employee/model/employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class EmployeeProvider extends ChangeNotifier {
  Employee? _searchedEmployee;

  Employee? get searchedEmployee => _searchedEmployee;

  void setEmployee(Employee? employee) {
    _searchedEmployee = employee;

    notifyListeners();
  }

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
      log(e.toString());
    }

    notifyListeners();
  }

  Future<bool> addEmployee(Employee employee) async {
    String body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:com="http://com.springbootsoap.allapis">
   <soapenv:Header/>
   <soapenv:Body>
      <com:addEmployeeRequest>
         <com:employeeInfo>
            <com:employeeId>${employee.id}</com:employeeId>
            <com:name>${employee.name}</com:name>
            <com:department>${employee.department}</com:department>
            <com:phone>${employee.phone}</com:phone>
            <com:address>${employee.address}</com:address>
         </com:employeeInfo>
      </com:addEmployeeRequest>
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
        setEmployee(null);
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> updateEmployee(Employee employee) async {
    String body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:com="http://com.springbootsoap.allapis">
   <soapenv:Header/>
   <soapenv:Body>
      <com:updateEmployeeRequest>
         <com:employeeInfo>
            <com:employeeId>${employee.id}</com:employeeId>
            <com:name>${employee.name}</com:name>
            <com:department>${employee.department}</com:department>
            <com:phone>${employee.phone}</com:phone>
            <com:address>${employee.address}</com:address>
         </com:employeeInfo>
      </com:updateEmployeeRequest>
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
        setEmployee(null);
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteEmployee(int id) async {
    String body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:com="http://com.springbootsoap.allapis">
   <soapenv:Header/>
   <soapenv:Body>
      <com:deleteEmployeeRequest>
         <com:employeeId>$id</com:employeeId>
      </com:deleteEmployeeRequest>
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
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
