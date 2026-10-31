import 'package:flutter/material.dart';

class StudentProfile {
  final String fullName;
  final String registrationNumber;
  final String department;
  final String degree;
  final String semester;
  final String section;
  final String email;
  final String phone;
  final String bloodGroup;
  final String validThru;
  final String issueDate;
  final String universityName;
  final String campus;
  final String emergencyContact;
  final String imagePath;
  final String logoPath;

  const StudentProfile({
    required this.fullName,
    required this.registrationNumber,
    required this.department,
    required this.degree,
    required this.semester,
    required this.section,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.validThru,
    required this.issueDate,
    required this.universityName,
    required this.campus,
    required this.emergencyContact,
    required this.imagePath,
    required this.logoPath,
  });

  StudentProfile copyWith({
    String? fullName,
    String? registrationNumber,
    String? department,
    String? degree,
    String? semester,
    String? section,
    String? email,
    String? phone,
    String? bloodGroup,
    String? validThru,
    String? issueDate,
    String? universityName,
    String? campus,
    String? emergencyContact,
    String? imagePath,
    String? logoPath,
  }) {
    return StudentProfile(
      fullName: fullName ?? this.fullName,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      department: department ?? this.department,
      degree: degree ?? this.degree,
      semester: semester ?? this.semester,
      section: section ?? this.section,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      validThru: validThru ?? this.validThru,
      issueDate: issueDate ?? this.issueDate,
      universityName: universityName ?? this.universityName,
      campus: campus ?? this.campus,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      imagePath: imagePath ?? this.imagePath,
      logoPath: logoPath ?? this.logoPath,
    );
  }

  static StudentProfile defaultProfile() {
    return const StudentProfile(
      fullName: 'Ayesha Khan',
      registrationNumber: 'FA21-BCS-089',
      department: 'Computer Science',
      degree: 'BS in Computer Science',
      semester: '6th Semester',
      section: 'Section BCS-6A',
      email: 'ayesha.khan@student.edu.pk',
      phone: '+92 301 5550192',
      bloodGroup: 'B+',
      validThru: '08 / 2026',
      issueDate: '09 / 2022',
      universityName: 'GLOBAL INSTITUTE OF TECHNOLOGY',
      campus: 'Main Academic Campus',
      emergencyContact: '+92 321 5550188',
      imagePath: 'assets/images/student_photo.jpg',
      logoPath: 'assets/images/university_logo.jpg',
    );
  }
}

class CardThemePreset {
  final String name;
  final List<Color> gradientColors;
  final Color accentColor;
  final Color cardBackground;
  final Color textColor;
  final Color secondaryTextColor;

  const CardThemePreset({
    required this.name,
    required this.gradientColors,
    required this.accentColor,
    required this.cardBackground,
    required this.textColor,
    required this.secondaryTextColor,
  });

  static const List<CardThemePreset> presets = [
    CardThemePreset(
      name: 'Royal Navy',
      gradientColors: [Color(0xFF0D1B2A), Color(0xFF1B263B), Color(0xFF415A77)],
      accentColor: Color(0xFFFFD166),
      cardBackground: Color(0xFF0F172A),
      textColor: Colors.white,
      secondaryTextColor: Color(0xFFCBD5E1),
    ),
    CardThemePreset(
      name: 'Emerald Executive',
      gradientColors: [Color(0xFF064E3B), Color(0xFF047857), Color(0xFF059669)],
      accentColor: Color(0xFFFBBF24),
      cardBackground: Color(0xFF064E3B),
      textColor: Colors.white,
      secondaryTextColor: Color(0xFFA7F3D0),
    ),
    CardThemePreset(
      name: 'Midnight Onyx',
      gradientColors: [Color(0xFF111827), Color(0xFF1F2937), Color(0xFF374151)],
      accentColor: Color(0xFF38BDF8),
      cardBackground: Color(0xFF111827),
      textColor: Colors.white,
      secondaryTextColor: Color(0xFF9CA3AF),
    ),
    CardThemePreset(
      name: 'Imperial Purple',
      gradientColors: [Color(0xFF3B0764), Color(0xFF581C87), Color(0xFF7E22CE)],
      accentColor: Color(0xFFF472B6),
      cardBackground: Color(0xFF3B0764),
      textColor: Colors.white,
      secondaryTextColor: Color(0xFFE9D5FF),
    ),
  ];
}
