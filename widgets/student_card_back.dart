import 'package:flutter/material.dart';
import '../models/student_profile.dart';
import 'card_decorations.dart';

class StudentCardBack extends StatelessWidget {
  final StudentProfile profile;
  final CardThemePreset theme;

  const StudentCardBack({
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
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Lanyard slot simulation at top
              const Padding(
                padding: EdgeInsets.only(top: 14),
                child: LanyardHangerWidget(),
              ),

              const SizedBox(height: 10),

              // Realistic Magnetic Stripe across the card
              Container(
                width: double.infinity,
                height: 48,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0F172A),
                      Color(0xFF1E293B),
                      Color(0xFF020617),
                      Color(0xFF1E293B),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    'SECURITY MAGNETIC ENCRYPTION • ISO/IEC 7810 ID-1',
                    style: TextStyle(
                      fontSize: 8,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Column(
                  children: [
                    // Institutional Instructions Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 0.8,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline, size: 14, color: theme.accentColor),
                              const SizedBox(width: 6),
                              Text(
                                'CAMPUS CARD DIRECTIVES',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8,
                                  color: theme.accentColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '• This card remains the official property of the university and must be presented on demand.\n'
                            '• Non-transferable. Loss must be reported immediately to the Security & Registrar Office.\n'
                            '• Grants access to campus facilities, central library, and examination halls.',
                            style: TextStyle(
                              fontSize: 9.5,
                              height: 1.35,
                              color: theme.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Contact & Emergency Information
                    _buildContactSection(),

                    const SizedBox(height: 14),

                    // QR Code & Registrar Signature row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Scannable QR Code
                        QrCodeWidget(
                          data: 'STUDENT:${profile.registrationNumber}|NAME:${profile.fullName}|DEPT:${profile.department}|EMAIL:${profile.email}',
                          size: 92,
                          color: const Color(0xFF0F172A),
                        ),
                        const SizedBox(width: 14),
                        // Official Signature & Validity Stamp
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'VALID THRU',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: theme.secondaryTextColor,
                                ),
                              ),
                              Text(
                                profile.validThru,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                  color: theme.accentColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Signature line
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'REGISTRAR SIGNATURE',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                      color: theme.secondaryTextColor,
                                    ),
                                  ),
                                  Icon(
                                    Icons.verified,
                                    size: 14,
                                    color: theme.accentColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Helpdesk URL & barcode
                    Text(
                      'Official Portal: www.university.edu.pk | UAN: 111-000-848',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: theme.secondaryTextColor,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Tap to flip back
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
                            'TAP CARD TO RETURN TO FRONT',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.email_outlined,
            label: 'Student Email',
            value: profile.email,
          ),
          const Divider(height: 10, thickness: 0.6, color: Colors.white12),
          _buildDetailRow(
            icon: Icons.phone_outlined,
            label: 'Contact No',
            value: profile.phone,
          ),
          const Divider(height: 10, thickness: 0.6, color: Colors.white12),
          _buildDetailRow(
            icon: Icons.emergency_outlined,
            label: 'Emergency Call',
            value: profile.emergencyContact,
          ),
          const Divider(height: 10, thickness: 0.6, color: Colors.white12),
          _buildDetailRow(
            icon: Icons.location_city_outlined,
            label: 'Campus',
            value: profile.campus,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: theme.accentColor),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: theme.secondaryTextColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
