import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bytesoles/userprofile/models/profile_model.dart';
import 'package:bytesoles/userprofile/widgets/profile_form_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  late ProfileModel _profile;
  late Map<String, dynamic> _editedFields;

  @override
  void initState() {
    super.initState();
    _profile = ProfileModel(
      username: "",
      firstName: "",
      lastName: "",
      email: "",
    );
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final request = context.read<CookieRequest>();
    
    try {
      final response = await request.get(
        'https://daffa-aqil31-bytesoles.pbp.cs.ui.ac.id/user_profile/get_profile/',
      );

      if (response != null) {
        setState(() {
          _profile = ProfileModel(
            username: response['username'] ?? '',
            firstName: response['first_name'] ?? '',
            lastName: response['last_name'] ?? '',
            email: response['email'] ?? '',
            shoeSize: double.tryParse(response['shoe_size']?.toString() ?? ''),
          );
          _editedFields = _profile.toJson();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memuat data profil')),
      );
    }
  }

  void _updateField(String field, String value) {
    setState(() {
      _editedFields[field] = value;
    });
  }

  Future<void> _saveChanges() async {
    final request = context.read<CookieRequest>();
    
    try {
      final response = await request.post(
        "https://daffa-aqil31-bytesoles.pbp.cs.ui.ac.id/user_profile/update_profile/",
        {
          'first_name': _editedFields['firstName'],
          'last_name': _editedFields['lastName'],
          'email': _editedFields['email'],
          'shoe_size': _editedFields['shoeSize'],
        },
      );

      if (response['status'] == 'success') {
        setState(() {
          _profile = ProfileModel(
            username: _profile.username,
            firstName: _editedFields['firstName'],
            lastName: _editedFields['lastName'],
            email: _editedFields['email'],
            shoeSize: double.tryParse(_editedFields['shoeSize'].toString()),
          );
          _isEditing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Terjadi kesalahan')),
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memperbarui profil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () => setState(() => _isEditing = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // const CircleAvatar(
              //   radius: 50,
              //   backgroundImage: AssetImage('assets/images/profile.png'),
              // ),
              const SizedBox(height: 20),
              ProfileFormWidget(
                profile: _profile,
                isEditing: _isEditing,
                onFieldChanged: _updateField,
                onSave: _saveChanges,
                onCancel: () => setState(() => _isEditing = false),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 