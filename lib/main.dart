import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:myapp/providers/auth_provider.dart' as my_app_auth_provider;
import 'package:myapp/providers/chatbot_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final my_app_auth_provider.AuthProvider _authProvider;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authProvider = my_app_auth_provider.AuthProvider();
    _router = GoRouter(
      refreshListenable: _authProvider,
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => DashboardScreen()),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupScreen(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final loggedIn = _authProvider.user != null;
        final isLogging =
            state.matchedLocation == '/login' ||
            state.matchedLocation == '/signup';
        final isOnboarding = state.matchedLocation == '/onboarding';

        if (!loggedIn && !isLogging && !isOnboarding) {
          return '/onboarding';
        }

        if (loggedIn && (isLogging || isOnboarding)) {
          return '/';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authProvider),
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
      ],
      child: MaterialApp.router(
        title: 'App NTI',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // ou .light, .dark
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
