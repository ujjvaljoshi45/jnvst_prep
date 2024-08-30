import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jnvst_prep/firebase_options.dart';
import 'package:jnvst_prep/providers/test_data_provider.dart';
import 'package:jnvst_prep/providers/user_provider.dart';
import 'package:jnvst_prep/screens/auth/login.dart';
import 'package:jnvst_prep/screens/home.dart';
import 'package:jnvst_prep/utils/tools.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

// test page
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(create: (_) => TestDataProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: false,
      child: MaterialApp(
        title: 'JNVST PREP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          LoginScreen.route: (_) => const LoginScreen(),
          HomeScreen.route: (_) => const HomeScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didChangeDependencies() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      final myUser = await getUserProvider(context).getUserFromDatabase(user!.uid);
      if (myUser == null) {
        await Future.delayed(const Duration(seconds: 1));
        mounted ? Navigator.pushNamed(context, LoginScreen.route) : debugPrint('not mounted');
      }
      else {
        await Future.delayed(const Duration(seconds: 1));
        mounted
            ? Navigator.pushNamed(context, HomeScreen.route)
            : debugPrint('not mounted');
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      mounted ? Navigator.pushNamed(context, LoginScreen.route) : debugPrint('not mounted');
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric( horizontal:  getWidth(context) * 0.2),
        child: const Center(
            child: LoadingIndicator(indicatorType: Indicator.ballScaleMultiple)
        ),
      ),
    );
  }
}
