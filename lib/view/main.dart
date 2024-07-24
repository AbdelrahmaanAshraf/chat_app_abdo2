import 'package:chat_app_abdo2/firebase_options.dart';
import 'package:chat_app_abdo2/model/cubit/auth/login_cubit/login_cubit.dart';
import 'package:chat_app_abdo2/model/cubit/auth/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app_abdo2/model/cubit/messages/message_cubit.dart';
import 'package:chat_app_abdo2/view/screens/auth_screens/login_screen.dart';
import 'package:chat_app_abdo2/view/screens/auth_screens/register_screen.dart';
import 'package:chat_app_abdo2/view/screens/home_screen.dart';
import 'package:chat_app_abdo2/view/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/cubit/observer.dart';
import '../services/local/shared_preference/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreference.sharedInit();
  Bloc.observer = MyBlocObserver();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => LoginCubit()),
        BlocProvider(create: (create) => SignUpCubit()),
        BlocProvider(create: (create) => MessageCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) {
          return MaterialApp(
            routes: {
              LoginScreen.id: (context) => const LoginScreen(),
              RegisterScreen.id: (context) => const RegisterScreen(),
              HomeScreen.id: (context) => HomeScreen(),
            },
            theme: ThemeData(primarySwatch: Colors.blue),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
