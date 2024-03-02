class UserTest {
  final int id;
  final String name;
  final String ethnic;
  final String address;
  final String phone;

  UserTest(
      {required this.id,
      required this.name,
      required this.ethnic,
      required this.address,
      required this.phone}
      );
}

class ImportData {
  // final List<UserTest> data;

  const ImportData();

  factory ImportData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
          'data': [
          {
            'id': int id,
            'name': String name,
            'ethnic': String ethnic,
            'address': String address,
            'phone': String phone,
            }
          ]
      } => const ImportData(),
      _ => throw const FormatException('Failed to load album.'),
    };
}
}
