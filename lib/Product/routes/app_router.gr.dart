// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MessagesRoute.name: (routeData) {
      final args = routeData.argsAs<MessagesRouteArgs>(
          orElse: () => const MessagesRouteArgs());
      return CustomPage<dynamic>(
        routeData: routeData,
        child: MessagesPage(
          key: args.key,
          userId: args.userId,
          userName: args.userName,
          userPhotoUrl: args.userPhotoUrl,
        ),
        transitionsBuilder: TransitionsBuilders.slideLeft,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
        transitionsBuilder: TransitionsBuilders.slideBottom,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignUpRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
        transitionsBuilder: TransitionsBuilders.slideBottom,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    ContactsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ContactsPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login',
          fullMatch: true,
        ),
        RouteConfig(
          MessagesRoute.name,
          path: '/messages',
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        RouteConfig(
          SignUpRoute.name,
          path: '/signup',
        ),
        RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        RouteConfig(
          ContactsRoute.name,
          path: '/contacts',
        ),
      ];
}

/// generated route for
/// [MessagesPage]
class MessagesRoute extends PageRouteInfo<MessagesRouteArgs> {
  MessagesRoute({
    Key? key,
    String? userId,
    String? userName,
    String? userPhotoUrl,
  }) : super(
          MessagesRoute.name,
          path: '/messages',
          args: MessagesRouteArgs(
            key: key,
            userId: userId,
            userName: userName,
            userPhotoUrl: userPhotoUrl,
          ),
        );

  static const String name = 'MessagesRoute';
}

class MessagesRouteArgs {
  const MessagesRouteArgs({
    this.key,
    this.userId,
    this.userName,
    this.userPhotoUrl,
  });

  final Key? key;

  final String? userId;

  final String? userName;

  final String? userPhotoUrl;

  @override
  String toString() {
    return 'MessagesRouteArgs{key: $key, userId: $userId, userName: $userName, userPhotoUrl: $userPhotoUrl}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/signup',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [ContactsPage]
class ContactsRoute extends PageRouteInfo<void> {
  const ContactsRoute()
      : super(
          ContactsRoute.name,
          path: '/contacts',
        );

  static const String name = 'ContactsRoute';
}
