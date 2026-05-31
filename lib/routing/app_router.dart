import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:myapp/screens/auth/signup_screen.dart';
import 'package:myapp/screens/dashboard/dashboard_screen.dart';
import 'package:myapp/screens/learning/lessons_list_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          return const SignupScreen();
        },
      ),
      GoRoute(
        path: '/dashboard',
        builder: (BuildContext context, GoRouterState state) {
          return DashboardScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'modules/:moduleId',
            builder: (BuildContext context, GoRouterState state) {
              final moduleId = state.pathParameters['moduleId']!;
              return LessonsListScreen(moduleId: moduleId);
            },
          ),
        ],
      ),
    ],
  );
}
