import 'package:rental_estate_app/Provider/favorite_provider.dart';
import 'package:rental_estate_app/model/category.dart';
import 'package:rental_estate_app/model/place_model.dart';
import 'package:rental_estate_app/view/login_screen.dart';
import 'package:rental_estate_app/view/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            // keep user login until logout

            StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const AppMainScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}

class UploadDataInFirebase extends StatelessWidget {
  const UploadDataInFirebase({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              saveCategoryItems();
            },
            child: Text("Upload data")),
      ),
    );
  }
}
