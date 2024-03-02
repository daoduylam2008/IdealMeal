class UserTest {
  final int id;
  final String name;
  final String ethnic;
  final String address;
  final String phoneNumber;

  UserTest(
      {required this.id,
      required this.name,
      required this.ethnic,
      required this.address,
      required this.phoneNumber});

  factory UserTest.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'ethnic': String ethnic,
        'address': String address,
        'phoneNumber': String phoneNumber,
      } =>
        UserTest(
            id: id,
            name: name,
            ethnic: ethnic,
            address: address,
            phoneNumber: phoneNumber),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
