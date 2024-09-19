class User {
  final String id;
  final String uuid;
  final String locale;
  final String role;
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final String? identityNumber;  // Burası null olabilir
  final String? avatarColor;     // Burası null olabilir
  final String? address;         // Burası null olabilir
  final String? city;            // Burası null olabilir
  final String? country;         // Burası null olabilir
  final String? zipCode;         // Burası null olabilir
  final String? ip;              // Burası null olabilir
  final bool isVerified;
  final String? createdAt;       // Burası null olabilir
  final String? updatedAt;       // Burası null olabilir
  final String? cardUserKey;     // Burası null olabilir

  User({
    required this.id,
    required this.uuid,
    required this.locale,
    required this.role,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    this.identityNumber,
    this.avatarColor,
    this.address,
    this.city,
    this.country,
    this.zipCode,
    this.ip,
    required this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.cardUserKey,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      uuid: json['uuid'] ?? '',
      locale: json['locale'] ?? '',
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      identityNumber: json['identityNumber'],  // Nullable alan
      avatarColor: json['avatarColor'],        // Nullable alan
      address: json['address'],                // Nullable alan
      city: json['city'],                      // Nullable alan
      country: json['country'],                // Nullable alan
      zipCode: json['zipCode'],                // Nullable alan
      ip: json['ip'],                          // Nullable alan
      isVerified: json['isVerified'] ?? false, // Boolean alan için default değer
      createdAt: json['createdAt'],            // Nullable alan
      updatedAt: json['updatedAt'],            // Nullable alan
      cardUserKey: json['cardUserKey'],        // Nullable alan
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'uuid': uuid,
      'locale': locale,
      'role': role,
      'name': name,
      'surname': surname,
      'email': email,
      'phoneNumber': phoneNumber,
      'identityNumber': identityNumber,
      'avatarColor': avatarColor,
      'address': address,
      'city': city,
      'country': country,
      'zipCode': zipCode,
      'ip': ip,
      'isVerified': isVerified,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'cardUserKey': cardUserKey,
    };
  }
}
