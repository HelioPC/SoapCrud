import 'dart:math';

import 'package:employee/model/employee.dart';
import 'package:employee/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  bool _isLoading = false;
  bool _isUpgradeMode = false;

  void _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    final employee = Employee(
      id: _isUpgradeMode ? _formData['id'] as int : Random().nextInt(1000) + 1,
      name: _formData['name'] as String,
      phone: _formData['phone'].toString(),
      department: _formData['department'] as String,
      address: _formData['address'] as String,
    );

    var response = _isUpgradeMode
        ? await context.read<EmployeeProvider>().updateEmployee(employee)
        : await context.read<EmployeeProvider>().addEmployee(employee);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response ? 'Successfully submited' : 'Fail to submit'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {},
          ),
        ),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Text(_isUpgradeMode ? 'Upgrade employee' : 'New employee'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => _isUpgradeMode = !_isUpgradeMode);
            },
            icon: Icon(_isUpgradeMode ? Icons.add : Icons.upgrade),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              if (_isUpgradeMode)
                TextFormField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  validator: (value) {
                    final phone = int.tryParse(
                          value?.replaceFirst(RegExp(','), '') ?? '-1',
                        ) ??
                        -1;

                    if (phone <= 0) {
                      return 'Invalid id';
                    }

                    if (phone.toString().startsWith('0')) {
                      return 'Number must not start with 0';
                    }

                    return null;
                  },
                  onSaved: (id) => _formData['id'] = int.parse(
                    id?.replaceFirst(RegExp(','), '') ?? '0',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(9),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    label: const Text('Id'),
                    fillColor: const Color.fromARGB(50, 255, 255, 255),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  final name = value ?? '';

                  if (name.trim().isEmpty) {
                    return 'This field is required';
                  }

                  if (name.length < 3) {
                    return '3 letters at least';
                  }

                  return null;
                },
                onSaved: (name) => _formData['name'] = name ?? '',
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: const Text('Name'),
                  fillColor: const Color.fromARGB(50, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.primary),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  final address = value ?? '';

                  if (address.trim().isEmpty) {
                    return 'This field is required';
                  }

                  if (address.length < 3) {
                    return '3 letters at least';
                  }

                  return null;
                },
                onSaved: (address) => _formData['address'] = address ?? '',
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: const Text('Address'),
                  fillColor: const Color.fromARGB(50, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.primary),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  final phone = int.tryParse(
                        value?.replaceFirst(RegExp(','), '') ?? '-1',
                      ) ??
                      -1;

                  if (phone <= 0) {
                    return 'Invalid phone number';
                  }

                  if (phone.toString().length != 9) {
                    return 'Number must have 9 digits';
                  }

                  if (!phone.toString().startsWith('9')) {
                    return 'Number must start with 9';
                  }

                  return null;
                },
                onSaved: (phone) => _formData['phone'] = int.parse(
                  phone?.replaceFirst(RegExp(','), '') ?? '0',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(9),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  label: const Text('Phone number'),
                  fillColor: const Color.fromARGB(50, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.primary),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  final address = value ?? '';

                  if (address.trim().isEmpty) {
                    return 'This field is required';
                  }

                  if (address.length < 3) {
                    return '3 letters at least';
                  }

                  return null;
                },
                textInputAction: TextInputAction.done,
                onSaved: (department) =>
                    _formData['department'] = department ?? '',
                decoration: InputDecoration(
                  label: const Text('Department'),
                  fillColor: const Color.fromARGB(50, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.primary),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _formData.clear();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
