# Excess Baggage Calculator

**ICT602 - Mobile Technology Individual Assignment**

## 1. Introduction

Excess Baggage Calculator is a mobile application developed using Flutter and Dart.

This application helps users calculate excess baggage fees for air travel based on baggage weight, ticket class, and excess baggage rate.

## 2. Application Features

- Enter baggage weight in kilograms.
- Select Economy or Business ticket class.
- Enter excess baggage rate per kilogram (RM).
- Calculate excess baggage weight.
- Calculate excess baggage charge.
- Calculate total payment including 8% service tax.
- Clear all input fields and results.
- Display error messages for invalid inputs.
- Navigate between Home and About pages.
- Open the GitHub repository from the About page.

## 3. Baggage Allowance

| Ticket Class | Free Baggage Allowance |
|---|---|
| Economy | 20 kg |
| Business | 40 kg |

## 4. Calculation Formula

Excess Weight = Baggage Weight - Free Baggage Allowance

If the result is negative, the excess weight is 0 kg.

Excess Charge = Excess Weight × Rate per kg

Total Payable = Excess Charge + (Excess Charge × 8%)

## 5. Example Calculation

**Input:**
- Baggage Weight: 25 kg
- Ticket Class: Economy
- Excess Rate: RM15/kg

**Output:**
- Excess Weight: 5.00 kg
- Excess Charge: RM75.00
- Total Payable: RM81.00

## 6. Tools Used

- Flutter
- Dart
- Android Studio
- Android Emulator
- GitHub

## 7. How to Run

1. Open the project in Android Studio.
2. Run `flutter pub get` to install dependencies.
3. Start an Android emulator.
4. Run `flutter run` to launch the application.

## 8. Testing

The application was checked using:

- `flutter analyze` — No issues found.
- `flutter test` — 2 automated tests passed.
- Manual testing using the assignment's four sample calculations.

## 9. Author Information

**Name:** Muhammad Lutfi Iskandar bin Mohd Faizal

**Matric Number:** 2024409888

**Course:** ICT602 - Mobile Technology

## 10. GitHub Repository

https://github.com/lutfiskandar21-crypto/excess-baggage-calculator

## Copyright

Copyright © 2026 Muhammad Lutfi Iskandar bin Mohd Faizal. All Rights Reserved.