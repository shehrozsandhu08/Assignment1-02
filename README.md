# Assignment 02: Student Card App (Flutter)

A modern, interactive Student Identity Card application built with Flutter that presents academic and personal credentials in an elegant, realistic university smart card format.

---

## 📋 Features & Requirements Checklist

| Requirement | Implemented | Details |
|---|:---:|---|
| **Student Image** | ✅ | High-resolution passport-style avatar with glowing border & verification badge |
| **Student Name** | ✅ | Prominent bold typography (`Ayesha Khan`) |
| **Registration Number** | ✅ | Monospaced badge pill (`FA21-BCS-089`) |
| **Department** | ✅ | `Computer Science` with degree subtitle (`BS Computer Science`) |
| **Semester & Section** | ✅ | `6th Semester` • `Section BCS-6A` |
| **Email & Contact** | ✅ | `ayesha.khan@student.edu.pk` • `+92 301 5550192` |
| **Emergency & Campus** | ✅ | Emergency Contact & Main Academic Campus |
| **3D Interactive Card Flip** | ✅ | Smooth 180° 3D flip between Front & Back on tap or button |
| **Customizer / Live Editor** | ✅ | In-app modal to change all details on the fly |
| **Card Theme Presets** | ✅ | Royal Navy, Emerald Executive, Midnight Onyx, Imperial Purple |
| **Security Elements** | ✅ | Golden EMV Chip, RFID icon, Magnetic Stripe, QR Code, Barcode |

---

## 📂 Submission Folder Structure

```text
Assignment_2_Submission/
├── lib/
│   ├── main.dart                      # Main app entry, 3D flip animation & home page
│   ├── models/
│   │   └── student_profile.dart       # StudentProfile model & CardTheme presets
│   └── widgets/
│       ├── card_decorations.dart      # CustomPainter for Chip, Barcode, QR Code & Watermark
│       ├── edit_student_sheet.dart    # Live bottom sheet form to customize student info
│       ├── student_card_front.dart    # Front side of the ID card
│       └── student_card_back.dart     # Back side with magnetic stripe & emergency info
├── assets/
│   └── images/
│       ├── student_photo.jpg          # Student ID avatar
│       └── university_logo.jpg        # University crest emblem
├── pubspec.yaml                       # Flutter configuration & assets declaration
└── screenshots/
    ├── 01_student_card_front.png      # Screenshot of running card front
    ├── 02_student_card_back.png       # Screenshot of running card back
    ├── 03_edit_student_details.png    # Screenshot of live customization form
    └── 04_card_theme_switch.png       # Screenshot of Emerald Executive theme
```

---

## 🚀 How to Run

1. Open terminal inside the project directory:
   ```bash
   cd "Assignment 2"
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app on Chrome, Windows desktop, or emulator:
   ```bash
   flutter run -d chrome
   ```
