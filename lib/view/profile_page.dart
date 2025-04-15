import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../view/login_screen.dart'; // Импортируем экран входа

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Функция выхода из профиля
  Future<void> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Icon(
                      Icons.notifications_outlined,
                      size: 35,
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.black54,
                      backgroundImage: NetworkImage(
                          "${FirebaseAuth.instance.currentUser!.photoURL}"),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Text.rich(
                      TextSpan(
                        text:
                        "${FirebaseAuth.instance.currentUser!.displayName}\n",
                        style:
                        const TextStyle(fontSize: 20, color: Colors.black),
                        children: const [
                          TextSpan(
                            text: "Show profile",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.black12),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,


                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.black12),
                const SizedBox(height: 15),
                const Text(
                  "Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                profileInfo(Icons.person_2_outlined, "Personal information"),
                profileInfo(Icons.notifications_outlined, "Notifications"),
                profileInfo(Icons.lock_outline, "Privacy and sharing"),
                const SizedBox(height: 15),
                const Text(
                  "Hosting",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 25),
                profileInfo(Icons.add_home_outlined, "List your space"),
                profileInfo(Icons.home_outlined, "Learn about hosting"),
                const SizedBox(height: 15),
                const Text(
                  "Support",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 25),
                profileInfo(Icons.help_outline, "Visit the Help Center"),

                profileInfo(Icons.edit_outlined, "Give us feedback"),
                const SizedBox(height: 15),
                const Text(
                  "Legal",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 25),
                profileInfo(Icons.menu_book_outlined, "Terms of Service"),
                profileInfo(Icons.menu_book_outlined, "Privacy Policy"),
                const SizedBox(height: 10),
                // Кнопка "Log out"
                InkWell(
                  onTap: () {
                    logOut(context);
                  },
                  child: const Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Version 24.34 (28004615)",
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding profileInfo(icon, name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 35,
                color: Colors.black.withOpacity(0.7),
              ),
              const SizedBox(width: 20),
              Text(
                name,
                style: const TextStyle(fontSize: 17),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}