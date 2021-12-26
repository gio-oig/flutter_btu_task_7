class Student {
  final int? id;
  final String name;
  final int age;

  Student({
    this.id,
    required this.name,
    required this.age,
  });

  factory Student.fromMap(Map<String, dynamic> json) =>
      Student(id: json['id'], name: json['name'], age: json['age']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
