class UserTest {
  final int id;
  final String birth;
  final String name;
  final String ethnic;
  final String address;
  final int phone;

  UserTest({
    required this.id,
      required this.birth,
      required this.name,
      required this.ethnic,
      required this.address,
      required this.phone});

  factory UserTest.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'birth': String birth,
        'name': String name,
        'ethnic': String ethnic,
        'address': String address,
        'phone': int phone,
      } =>
        UserTest(
            id: id, birth: birth, name: name, ethnic: ethnic, address: address, phone: phone),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
