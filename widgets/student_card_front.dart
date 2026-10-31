import 'package:flutter/material.dart';
import '../models/student_profile.dart';
import 'card_decorations.dart';

class StudentCardFront extends StatelessWidget {
  final StudentProfile profile;
  final CardThemePreset theme;

  const StudentCardFront({
    super.key,
    required this.profile,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      constraints: const BoxConstraints(minHeight: 560),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: theme.gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 28,
            offset: const Offset(0, 16),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: theme.accentColor.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.accentColor.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: WatermarkBackground(
          patternColor: Colors.white.withValues(alpha: 0.04),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Lanyard slot simulation
                const LanyardHangerWidget(),

                const SizedBox(height: 8),

                // University Header with Crest Logo
                _buildUniversityHeader(),

                const SizedBox(height: 14),

                // Golden Chip & NFC Icon Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SmartChipWidget(width: 46, height: 34),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.contactless_outlined,
                            size: 18,
                            color: theme.accentColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'RFID',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: theme.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Student Photo Avatar with glowing border
                _buildStudentPhoto(),

                const SizedBox(height: 12),

                // Student Name
                Text(
                  profile.fullName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                // Registration Number Badge
                _buildRegNoBadge(),

                const SizedBox(height: 14),

                // Department & Degree
                _buildDegreeInfo(),

                const SizedBox(height: 14),

                // Academic Information Grid (Semester, Section, Blood Group, Validity)
                _buildAcademicGrid(),

                const SizedBox(height: 14),

                // Barcode at bottom
                BarcodeWidget(
                  code: profile.registrationNumber,
                  height: 34,
                  barColor: Colors.white.withValues(alpha: 0.9),
                  textColor: theme.secondaryTextColor,
                ),

                const SizedBox(height: 8),

                // Flip Hint indicator
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app_outlined,
                        size: 13,
                        color: theme.accentColor.withValues(alpha: 0.8),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'TAP CARD TO FLIP FOR BACK DETAILS',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w700,
                          color: theme.accentColor.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUniversityHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // University Logo
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.accentColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              profile.logoPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: theme.cardBackground,
                child: Icon(Icons.school, color: theme.accentColor, size: 26),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // University Name & Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.universityName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Wrap(
                spacing: 6,
                runSpacing: 2,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.accentColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'STUDENT CARD',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  Text(
                    'SESSION 2022-26',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: theme.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStudentPhoto() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 116,
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.accentColor,
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
                BoxShadow(
                  color: theme.accentColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13.5),
              child: Image.asset(
                profile.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF334155),
                  child: const Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
          // Verified active status badge
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              size: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegNoBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.accentColor.withValues(alpha: 0.6),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.badge_outlined,
            size: 14,
            color: theme.accentColor,
          ),
          const SizedBox(width: 6),
          Text(
            'REG: ${profile.registrationNumber}',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Courier',
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: theme.accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDegreeInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.computer, size: 15, color: theme.accentColor),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  profile.department,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            profile.degree,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: theme.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoTile(
            label: 'SEMESTER',
            value: profile.semester,
            icon: Icons.calendar_month_outlined,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildInfoTile(
            label: 'SECTION',
            value: profile.section,
            icon: Icons.groups_outlined,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildInfoTile(
            label: 'BLOOD GRP',
            value: profile.bloodGroup,
            icon: Icons.bloodtype_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 14, color: theme.accentColor),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: theme.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
