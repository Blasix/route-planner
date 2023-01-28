import 'package:hooks_riverpod/hooks_riverpod.dart';

class Route {
  const Route({
    required this.uuid,
    required this.isWalking,
    required this.distance,
    required this.route,
  });

  final String uuid;
  final bool isWalking;
  final int distance;
  final List route;
}

final _likedRoutes = [
  //Todo: get routes from database
  const Route(uuid: '', isWalking: true, distance: 10, route: []),
];

final _recentRoutes = [
  //Todo: get routes from shared preferences
  const Route(uuid: '', isWalking: true, distance: 10, route: []),
];

final likedRoutesProvider = Provider<List<Route>>((ref) {
  return _likedRoutes;
});

final recentRoutesProvider = Provider<List<Route>>((ref) {
  return _recentRoutes;
});
