import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_btu_task_bd/data/models/student.dart';
import 'package:flutter_btu_task_bd/db/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sqlite'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'age',
                ),
              ),
              FutureBuilder<List<Student>>(
                future: DatabaseHelper.instance.getStudents(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('loading...');
                  }
                  return snapshot.data!.isEmpty
                      ? const Center(child: Text('no students'))
                      : ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: snapshot.data!.map((student) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  title: Text(student.name),
                                  subtitle: Text('age: ${student.age}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        DatabaseHelper.instance
                                            .remove(student.id!);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await DatabaseHelper.instance.add(Student(
              name: nameController.text, age: int.parse(ageController.text)));
          setState(() {
            nameController.clear();
            ageController.clear();
          });
        },
      ),
    );
  }
}
