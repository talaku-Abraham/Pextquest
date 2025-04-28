import 'package:go_router/go_router.dart';
import 'package:pextquest/widgets/favorite_screen.dart';
import 'package:pextquest/widgets/homepage.dart';
import 'package:pextquest/widgets/rootlayout.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: "/", builder: (context, state) => Rootlayout(child: Home())),
    GoRoute(
      path: "/favorite",
      builder: (context, state) => Rootlayout(child: FavoriteScreen()),
    ),
  ],
);
