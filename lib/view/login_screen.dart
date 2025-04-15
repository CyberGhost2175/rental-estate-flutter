import 'package:rental_estate_app/Authentication/google_authentication.dart';
import 'package:rental_estate_app/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Authentication/phone_authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Список стран для выпадающего меню
  final List<Map<String, String>> _countries = [
    {'name': 'Kazakhstan', 'code': '+7'},
    {'name': 'United States', 'code': '+1'},
    {'name': 'United Kingdom', 'code': '+44'},
    {'name': 'Germany', 'code': '+49'},
    {'name': 'France', 'code': '+33'},
  ];

  Map<String, String>? _selectedCountry;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.first; // Установка страны по умолчанию
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[900], // Темно-серый фон
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Log in or sign up",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Белый текст
                  ),
                ),
              ),
              const Divider(
                color: Colors.white30, // Белая линия с прозрачностью
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to Rental Estate Agency",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Белый текст
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    // Поле выбора страны и номера телефона
                    phoneNumberField(size),
                    const SizedBox(height: 10),
                    RichText(
                      text: const TextSpan(
                        text:
                        "We'll call or text you to confirm your number. Standard message and data rates apply. ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70, // Светло-белый текст
                        ),
                        children: [
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.orange, // Оранжевый текст
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // Кнопка "Continue"
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange, // Оранжевый цвет кнопки
                      ),
                      child: InkWell(
                        onTap: () async {
                          String fullPhoneNumber = '${_selectedCountry!['code']} ${_phoneController.text.replaceAll(' ', '')}';
                          await sendVerificationCode(fullPhoneNumber, context);
                        },
                        child: const Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Белый текст
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.026),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.white30, // Белая линия с прозрачностью
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "or",
                            style: TextStyle(fontSize: 18, color: Colors.white), // Белый текст
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.white30, // Белая линия с прозрачностью
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    // Кнопка входа через Google
                    InkWell(
                      onTap: () async {
                        await FirebaseAuthServices().signInWithGoogle();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppMainScreen(),
                          ),
                        );
                      },
                      child: socialIcons(
                        size,
                        FontAwesomeIcons.google,
                        "Continue with Google",
                        Colors.red,
                        27,
                      ),
                    ),
                    socialIcons(
                      size,
                      Icons.email_outlined,
                      "Continue with email",
                      Colors.green,
                      30,
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Need help?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white, // Белый текст
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Виджет для кнопок социальных сетей
  Padding socialIcons(Size size, IconData icon, String name, Color color, double iconSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white30), // Белая граница с прозрачностью
        ),
        child: Row(
          children: [
            SizedBox(width: size.width * 0.05),
            Icon(
              icon,
              color: color,
              size: iconSize,
            ),
            SizedBox(width: size.width * 0.18),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white, // Белый текст
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  // Поле выбора страны и номера телефона
  Container phoneNumberField(Size size) {
    return Container(
      width: size.width,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white30, // Белая граница с прозрачностью
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
              top: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Country/Region",
                  style: TextStyle(
                    color: Colors.white70, // Светло-белый текст
                  ),
                ),
                DropdownButton<Map<String, String>>(
                  value: _selectedCountry,
                  items: _countries.map((country) {
                    return DropdownMenuItem<Map<String, String>>(
                      value: country,
                      child: Text(
                        '${country['name']} (${country['code']})',
                        style: const TextStyle(color: Colors.white), // Белый текст
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value!;
                    });
                  },
                  dropdownColor: Colors.grey[800], // Цвет фона выпадающего меню
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white), // Белая стрелка
                  underline: Container(), // Убираем подчеркивание
                  isExpanded: true, // Расширяем выпадающий список
                  style: const TextStyle(color: Colors.white), // Белый текст
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white30, // Белая линия с прозрачностью
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white), // Белый текст
              decoration: const InputDecoration(
                hintText: "Phone number",
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white70, // Светло-белый текст
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}