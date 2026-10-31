import 'package:flutter/material.dart';
import '../models/student_profile.dart';

class EditStudentSheet extends StatefulWidget {
  final StudentProfile currentProfile;
  final ValueChanged<StudentProfile> onSave;

  const EditStudentSheet({
    super.key,
    required this.currentProfile,
    required this.onSave,
  });

  @override
  State<EditStudentSheet> createState() => _EditStudentSheetState();
}

class _EditStudentSheetState extends State<EditStudentSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _regController;
  late final TextEditingController _deptController;
  late final TextEditingController _degreeController;
  late final TextEditingController _semController;
  late final TextEditingController _secController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bloodController;
  late final TextEditingController _validController;
  late final TextEditingController _univController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final p = widget.currentProfile;
    _nameController = TextEditingController(text: p.fullName);
    _regController = TextEditingController(text: p.registrationNumber);
    _deptController = TextEditingController(text: p.department);
    _degreeController = TextEditingController(text: p.degree);
    _semController = TextEditingController(text: p.semester);
    _secController = TextEditingController(text: p.section);
    _emailController = TextEditingController(text: p.email);
    _phoneController = TextEditingController(text: p.phone);
    _bloodController = TextEditingController(text: p.bloodGroup);
    _validController = TextEditingController(text: p.validThru);
    _univController = TextEditingController(text: p.universityName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _regController.dispose();
    _deptController.dispose();
    _degreeController.dispose();
    _semController.dispose();
    _secController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bloodController.dispose();
    _validController.dispose();
    _univController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      final updated = widget.currentProfile.copyWith(
        fullName: _nameController.text.trim(),
        registrationNumber: _regController.text.trim(),
        department: _deptController.text.trim(),
        degree: _degreeController.text.trim(),
        semester: _semController.text.trim(),
        section: _secController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        bloodGroup: _bloodController.text.trim(),
        validThru: _validController.text.trim(),
        universityName: _univController.text.trim(),
      );
      widget.onSave(updated);
      Navigator.of(context).pop();
    }
  }

  void _resetToDefault() {
    final def = StudentProfile.defaultProfile();
    _nameController.text = def.fullName;
    _regController.text = def.registrationNumber;
    _deptController.text = def.department;
    _degreeController.text = def.degree;
    _semController.text = def.semester;
    _secController.text = def.section;
    _emailController.text = def.email;
    _phoneController.text = def.phone;
    _bloodController.text = def.bloodGroup;
    _validController.text = def.validThru;
    _univController.text = def.universityName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Customize Student Card',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _resetToDefault,
                    icon: const Icon(Icons.refresh, size: 16, color: Color(0xFF38BDF8)),
                    label: const Text(
                      'Reset',
                      style: TextStyle(color: Color(0xFF38BDF8), fontSize: 13),
                    ),
                  ),
                ],
              ),
              const Text(
                'Personalize the student academic details to update the live ID card immediately.',
                style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 18),

              _buildField('Full Name', _nameController, Icons.person, 'Enter your name'),
              _buildField('Registration Number', _regController, Icons.badge, 'e.g. FA21-BCS-089'),
              _buildField('Department', _deptController, Icons.business, 'e.g. Computer Science'),
              _buildField('Degree Program', _degreeController, Icons.school, 'e.g. BS Computer Science'),

              Row(
                children: [
                  Expanded(
                    child: _buildField('Semester', _semController, Icons.calendar_month, '6th Semester'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildField('Section', _secController, Icons.groups, 'BCS-6A'),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: _buildField('Blood Group', _bloodController, Icons.bloodtype, 'e.g. B+'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildField('Valid Thru', _validController, Icons.event_available, '08 / 2026'),
                  ),
                ],
              ),

              _buildField('Student Email', _emailController, Icons.email, 'student@edu.pk'),
              _buildField('Contact Number', _phoneController, Icons.phone, '+92 300 1234567'),
              _buildField('University Name', _univController, Icons.account_balance, 'University Name'),

              const SizedBox(height: 16),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text(
                    'Apply & Update Card',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    IconData icon,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFCBD5E1),
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
              prefixIcon: Icon(icon, color: const Color(0xFF94A3B8), size: 18),
              filled: true,
              fillColor: const Color(0xFF1E293B),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF334155)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF334155)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF38BDF8), width: 1.5),
              ),
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Field required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
