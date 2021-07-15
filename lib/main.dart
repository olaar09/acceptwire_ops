import 'package:acceptwire/data/podo/lecture_podo.dart';
import 'package:acceptwire/data/repository/auth_repository.dart';
import 'package:acceptwire/data/repository/meta_repository.dart';
import 'package:acceptwire/logic/auth_bloc/bloc.dart';
import 'package:acceptwire/logic/meta_bloc/bloc.dart';
import 'package:acceptwire/logic/network_bloc/network_bloc.dart';
import 'package:acceptwire/presentation/login.dart';
import 'package:acceptwire/presentation/onboarding.dart';
import 'package:acceptwire/presentation/profile.dart';
import 'package:acceptwire/presentation/splash.dart';
import 'package:acceptwire/utils/helpers/rest_client.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp _firebaseApp = await Firebase.initializeApp();

  runApp(MyApp(firebaseApp: _firebaseApp));
}

class MyApp extends StatefulWidget {
  final FirebaseApp firebaseApp;

  MyApp({required this.firebaseApp});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthRepository _authRepository = AuthRepository();
  final MetaDataRepo _metaDataRepo = MetaDataRepo();
  final Connectivity connectivity = Connectivity();
  final RestClientRepository _restClientRepository = RestClientRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository),
        RepositoryProvider(create: (context) => _metaDataRepo),
        RepositoryProvider(create: (context) => _restClientRepository)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => NetworkBloc(connectivity: connectivity)),
          BlocProvider(
              create: (context) => AuthBloc(
                  authRepository: _authRepository,
                  metaDataRepo: _metaDataRepo)),
          BlocProvider(
              create: (context) => MetaDataBloc(
                  metaDataRepo: _metaDataRepo,
                  authRepository: _authRepository)),
        ],
        child: MaterialApp(
          title: 'acceptwire',
          theme: ThemeData(
            fontFamily: 'SamoSans',
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(
            builder: (_) => LoginPage(), fullscreenDialog: true);
      case '/onboard':
        return MaterialPageRoute(builder: (_) => OnBoarding());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
