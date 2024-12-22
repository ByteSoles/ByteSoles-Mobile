import 'package:flutter/material.dart';
import 'package:bytesoles/userprofile/models/profile_model.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProfileFormWidget extends StatefulWidget {
  final ProfileModel profile;
  final bool isEditing;
  final Function(String, String) onFieldChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const ProfileFormWidget({
    Key? key,
    required this.profile,
    required this.isEditing,
    required this.onFieldChanged,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController shoeSizeController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    firstNameController = TextEditingController(text: widget.profile.firstName);
    lastNameController = TextEditingController(text: widget.profile.lastName);
    emailController = TextEditingController(text: widget.profile.email);
    shoeSizeController = TextEditingController(
      text: widget.profile.shoeSize?.toString() ?? '',
    );
    // addressController = TextEditingController(text: widget.profile.shippingAddress ?? '');
  }

  Future<void> _deleteAccount() async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Akun'),
        content: Text('Apakah Anda yakin ingin menghapus akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm) {
      final request = context.read<CookieRequest>();
      try {
        final response = await request.post(
          'http://localhost:8000/user_profile/delete_account/',
          {},
        );
        if (response['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Akun berhasil dihapus')),
          );
          Navigator.pushReplacementNamed(context, '/login');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus akun: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: const Icon(
            Icons.person,
            color: Colors.black,
            size: 80,
          ),
        ),
        const SizedBox(height: 20),
        
        if (widget.isEditing) ...[
          _buildTextField(
            "First Name",
            firstNameController,
            (value) => widget.onFieldChanged('firstName', value),
          ),
          _buildTextField(
            "Last Name",
            lastNameController,
            (value) => widget.onFieldChanged('lastName', value),
          ),
          _buildTextField(
            "Email",
            emailController,
            (value) => widget.onFieldChanged('email', value),
          ),
          _buildTextField(
            "Shoe Size",
            shoeSizeController,
            (value) => widget.onFieldChanged('shoeSize', value),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: widget.onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Save'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: widget.onCancel,
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ] else ...[
          _buildInfoRow("First Name", widget.profile.firstName),
          _buildInfoRow("Last Name", widget.profile.lastName),
          _buildInfoRow("Email", widget.profile.email),
          _buildInfoRow("Shoe Size", widget.profile.shoeSize?.toString() ?? '-'),
          // _buildInfoRow("Shipping Address", widget.profile.shippingAddress ?? '-'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final request = context.read<CookieRequest>();
              // Langsung set loggedIn ke false dan clear data
              request.loggedIn = false;
              request.jsonData = {};
              // Redirect ke homepage dan clear semua route sebelumnya
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Logout'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _deleteAccount,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    Function(String) onChanged, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? value : '-',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }
}