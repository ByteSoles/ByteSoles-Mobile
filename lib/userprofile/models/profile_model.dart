class ProfileModel {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final double? shoeSize;
  final String? shippingAddress;
  final String? profilePicture;

  ProfileModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.shoeSize,
    this.shippingAddress,
    this.profilePicture,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      shoeSize: json['shoe_size']?.toDouble(),
      shippingAddress: json['shipping_address'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'shoe_size': shoeSize,
      'shipping_address': shippingAddress,
      'profile_picture': profilePicture,
    };
  }
} 