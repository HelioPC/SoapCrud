import 'package:employee/presentation/pages/detail/detail_page.dart';
import 'package:employee/presentation/pages/form/form_page.dart';
import 'package:employee/shared/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getEmployee() {
    context
        .read<EmployeeProvider>()
        .getEmployeeById(int.parse(_controller.text));
  }

  void _reset() {
    context.read<EmployeeProvider>().setEmployee(null);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final employee = context.watch<EmployeeProvider>().searchedEmployee;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Employee CRUD'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FormPage()),
              );
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<EmployeeProvider>().setEmployee(null);
          _controller.clear();
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search employee by id',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {
                        employee == null ? _getEmployee() : _reset();
                      },
                      child: Text(employee != null ? 'Limpar' : 'Pesquisar')),
                ],
              ),
              const SizedBox(height: 50),
              employee != null
                  ? Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailPage(employee: employee);
                              },
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          child: Text(employee.name[0].toUpperCase()),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            var response = await context
                                .read<EmployeeProvider>()
                                .deleteEmployee(employee.id);

                            if (response) {
                              _reset();
                            }

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    response
                                        ? 'Successfully deleted'
                                        : 'Fail to delete',
                                  ),
                                  duration: const Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'Dismiss',
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        title: Text(employee.name),
                        subtitle: Text(employee.phone),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
