import 'package:flutter/material.dart';

extension type const UserName._(String value) {
  factory UserName(String value) {
    if (value.isEmpty) throw EmptyUserNameException;
    return UserName._(value);
  }
}

extension type const UserProfile._(UserName userName) {
  factory UserProfile(UserName name) => UserProfile._(name);
  UserName get name => userName;
}

class EmptyUserNameException implements Exception {
  @override
  String toString() {
    return 'UserName cannot be empty';
  }
}

abstract class ProfileDataAdapter {
  UserProfile getUserProfileData();
  UserProfile saveUserProfileData(UserProfile profile);
}

class ProfileDataAdapterImpl implements ProfileDataAdapter {
  @override
  UserProfile getUserProfileData() {
    return UserProfile(UserName("John Doe"));
  }

  @override
  UserProfile saveUserProfileData(UserProfile profile) {
    return profile;
  }
}

class ProfileManager {
  final ProfileDataAdapter _dataAdapter;

  ProfileManager(this._dataAdapter);

  UserProfile getUserProfile() {
    return _dataAdapter.getUserProfileData();
  }

  UserProfile updateUserProfile(UserName newName) {
    final updatedProfile = UserProfile(newName);
    return _dataAdapter.saveUserProfileData(updatedProfile);
  }
}

class SingleResponsibilityScreen extends StatefulWidget {
  const SingleResponsibilityScreen({super.key});

  @override
  _SingleResponsibilityScreenState createState() =>
      _SingleResponsibilityScreenState();
}

class _SingleResponsibilityScreenState
    extends State<SingleResponsibilityScreen> {
  late final ProfileDataAdapter _profileAdapter;
  late final ProfileManager _profileManager;
  late UserProfile userProfile;

  @override
  void initState() {
    super.initState();
    _profileAdapter = ProfileDataAdapterImpl();
    _profileManager = ProfileManager(_profileAdapter);
    userProfile = _profileManager.getUserProfile();
  }

  void _updateProfile() {
    setState(() {
      userProfile = _profileManager.updateUserProfile(UserName("fenny"));
    });
  }

  void _resetProfile() {
    setState(() {
      userProfile = _profileManager.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Single Responsibility Principle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Current Profile: ${userProfile.name}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text("Update Profile"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _resetProfile,
              child: const Text("Reset Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
