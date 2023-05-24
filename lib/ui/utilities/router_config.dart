import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_clone/data/app_routes.dart';
import 'package:keep_clone/ui/screens/home/home.dart';
import 'package:keep_clone/ui/screens/start/start.dart';

final routerConfig = GoRouter(routes: [
  GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
      name: AppRoutes.home,
      routes: [],
      redirect: (_, state) {
        if (FirebaseAuth.instance.currentUser == null) {
          return AppRoutes.start;
        }
        return state.location;
      }),
  GoRoute(
      path: AppRoutes.start,
      builder: (context, state) => const GetStartedScreen(),
      name: AppRoutes.start,
      routes: []),
]);
