import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/student_profile.dart';
import 'widgets/student_card_front.dart';
import 'widgets/student_card_back.dart';
import 'widgets/edit_student_sheet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const StudentCardApp());
}

class StudentCardApp extends StatelessWidget {
  const StudentCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Card App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F19),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF38BDF8),
          surface: Color(0xFF111827),
        ),
        fontFamily: 'Segoe UI',
      ),
      home: const StudentCardHomePage(),
    );
  }
}

class StudentCardHomePage extends StatefulWidget {
  const StudentCardHomePage({super.key});

  @override
  State<StudentCardHomePage> createState() => _StudentCardHomePageState();
}

class _StudentCardHomePageState extends State<StudentCardHomePage>
    with SingleTickerProviderStateMixin {
  late StudentProfile _profile;
  late CardThemePreset _selectedTheme;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  bool _isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    _profile = StudentProfile.defaultProfile();
    _selectedTheme = CardThemePreset.presets.first;

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    )..addListener(() {
        setState(() {
          _isFrontVisible = _flipAnimation.value < 0.5;
        });
      });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleCardFlip() {
    if (_flipController.status == AnimationStatus.completed) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
  }

  void _openEditSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => EditStudentSheet(
        currentProfile: _profile,
        onSave: (updated) {
          setState(() {
            _profile = updated;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF34D399), size: 18),
                  SizedBox(width: 8),
                  Text('Student Card updated successfully!'),
                ],
              ),
              backgroundColor: const Color(0xFF1E293B),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showShareConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.qr_code_scanner, color: Color(0xFF38BDF8), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Digital ID verified for ${_profile.fullName} (${_profile.registrationNumber})',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: const Color(0xFF38BDF8),
          onPressed: () {},
        ),
        backgroundColor: const Color(0xFF0F172A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F19),
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white12),
              ),
              child: const Icon(
                Icons.badge_rounded,
                color: Color(0xFF38BDF8),
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student Card',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Assignment 02 • Flutter App',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Edit Card Details',
            icon: const Icon(Icons.edit_note_rounded, color: Color(0xFF38BDF8)),
            onPressed: _openEditSheet,
          ),
          IconButton(
            tooltip: 'Card Actions',
            icon: const Icon(Icons.share_outlined, color: Colors.white70),
            onPressed: _showShareConfirmation,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Theme Selector Row
            _buildThemeSelector(),

            const SizedBox(height: 16),

            // 3D Flip Card Container with gesture detection
            Center(
              child: GestureDetector(
                onTap: _toggleCardFlip,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    final angle = _flipAnimation.value * math.pi;
                    final isFront = _flipAnimation.value < 0.5;

                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0012)
                        ..rotateY(angle),
                      alignment: Alignment.center,
                      child: isFront
                          ? StudentCardFront(
                              profile: _profile,
                              theme: _selectedTheme,
                            )
                          : Transform(
                              transform: Matrix4.identity()..rotateY(math.pi),
                              alignment: Alignment.center,
                              child: StudentCardBack(
                                profile: _profile,
                                theme: _selectedTheme,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Quick Interactive Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _toggleCardFlip,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E293B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.white12),
                    ),
                  ),
                  icon: Icon(
                    _isFrontVisible ? Icons.flip_to_back : Icons.flip_to_front,
                    size: 18,
                    color: _selectedTheme.accentColor,
                  ),
                  label: Text(_isFrontVisible ? 'Flip to Back' : 'Flip to Front'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _openEditSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit Details'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Detailed Information Breakdown Accordion / Card
            _buildDetailedAcademicSummary(),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          const Icon(Icons.palette_outlined, size: 16, color: Color(0xFF94A3B8)),
          const SizedBox(width: 8),
          const Text(
            'Card Theme:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFCBD5E1),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: CardThemePreset.presets.map((preset) {
                  final isSelected = _selectedTheme.name == preset.name;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTheme = preset;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? preset.accentColor.withValues(alpha: 0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? preset.accentColor
                              : Colors.white.withValues(alpha: 0.15),
                          width: isSelected ? 1.5 : 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: preset.gradientColors),
                              border: Border.all(color: Colors.white38, width: 0.5),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            preset.name,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedAcademicSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.assignment_outlined, size: 18, color: Color(0xFF38BDF8)),
                  SizedBox(width: 8),
                  Text(
                    'Student Record Overview',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF10B981), width: 0.8),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(radius: 3, backgroundColor: Color(0xFF10B981)),
                    SizedBox(width: 5),
                    Text(
                      'VERIFIED ID',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF34D399),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildSummaryRow(Icons.person_outline, 'Student Name', _profile.fullName),
          _buildSummaryRow(Icons.pin_outlined, 'Registration No.', _profile.registrationNumber),
          _buildSummaryRow(Icons.school_outlined, 'Department', _profile.department),
          _buildSummaryRow(Icons.menu_book_outlined, 'Program Degree', _profile.degree),
          _buildSummaryRow(Icons.calendar_today_outlined, 'Current Semester', _profile.semester),
          _buildSummaryRow(Icons.meeting_room_outlined, 'Assigned Section', _profile.section),
          _buildSummaryRow(Icons.email_outlined, 'Institutional Email', _profile.email),
          _buildSummaryRow(Icons.bloodtype_outlined, 'Blood Group', _profile.bloodGroup),
          _buildSummaryRow(Icons.lock_clock_outlined, 'Card Validity', _profile.validThru),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 8),
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
