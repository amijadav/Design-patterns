import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String email;
  final int age;
  final String address;

  UserProfile({
    required this.name,
    required this.email,
    required this.age,
    required this.address,
  });

  @override
  String toString() {
    return 'UserProfile(name: $name, email: $email, age: $age, address: $address)';
  }
}

class UserProfileBuilder {
  // Default values for the properties
  String _name = 'Unknown';
  String _email = 'example@example.com';
  int _age = 18;
  String _address = 'No Address Provided';

  // Chainable methods to set properties
  UserProfileBuilder setName(String name) {
    _name = name;
    return this;
  }

  UserProfileBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  UserProfileBuilder setAge(int age) {
    _age = age;
    return this;
  }

  UserProfileBuilder setAddress(String address) {
    _address = address;
    return this;
  }

  // Build method to create the UserProfile instance
  UserProfile build() {
    return UserProfile(
      name: _name,
      email: _email,
      age: _age,
      address: _address,
    );
  }
}

class BuilderPatternExample2 extends StatelessWidget {
  const BuilderPatternExample2({super.key});

  @override
  Widget build(BuildContext context) {
    // Using the builder to create a customized user profile
    UserProfile user = UserProfileBuilder()
        .setName('John Doe')
        .setEmail('john.doe@example.com')
        .setAge(30)
        .setAddress('123 Main Street, Springfield')
        .build();

    // Create another profile with only partial customization
    UserProfile defaultUser = UserProfileBuilder().setName('Jane Doe').build();

    return Scaffold(
      appBar: AppBar(title: const Text('User Profiles')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customized User Profile:',
            ),
            Text(user.toString()),
            const SizedBox(height: 20),
            const Text(
              'Default User Profile:',
            ),
            Text(defaultUser.toString()),
          ],
        ),
      ),
    );
  }
}
