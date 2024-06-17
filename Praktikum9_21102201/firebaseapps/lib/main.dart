import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:pertemuan_9/bloc/login/login_cubit.dart';
import 'package:pertemuan_9/ui/home_screen.dart';
import 'package:pertemuan_9/ui/login.dart';
import 'package:pertemuan_9/ui/splash.dart';
import 'package:pertemuan_9/utils/routes.dart';
import 'bloc/register/register_cubit.dart';
import 'firebase_options.dart'; // Assuming this contains DefaultFirebaseOptions.currentPlatform
import 'utils/routes.dart'; // Assuming this contains generateRoute and NAV_KEY

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
    // Handle Firebase initialization error here
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
      ],
      child: MaterialApp(
        title: "Praktikum 9",
        debugShowCheckedModeBanner: false,
        navigatorKey: NAV_KEY,
        onGenerateRoute: generateRoute,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return HomeScreen();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
