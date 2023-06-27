import 'package:employee/provider/employee_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final employee = context.watch<EmployeeProvider>().searchedEmployee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee CRUD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
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
                      Provider.of<EmployeeProvider>(
                        context,
                        listen: false,
                      ).getEmployeeById(int.parse(_controller.text));
                    },
                    child: const Text('Pesquisar')),
              ],
            ),
            const SizedBox(height: 50),
            employee != null
                ? Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(employee.name[0].toUpperCase()),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_circle_right),
                      ),
                      title: Text(employee.name),
                      subtitle: Text(employee.address),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
