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
    SplashRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MessagesRoute.name: (routeData) {
      final args = routeData.argsAs<MessagesRouteArgs>(
          orElse: () => const MessagesRouteArgs());
      return CustomPage<dynamic>(
        routeData: routeData,
        child: MessagesPage(
          key: args.key,
          userId: args.userId,
          msgRead: args.msgRead,
          currentUserDisplayName: args.currentUserDisplayName,
          pushToken: args.pushToken,
          groupChatId: args.groupChatId,
          isFromContactsPage: args.isFromContactsPage,
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
          redirectTo: '/splash',
          fullMatch: true,
        ),
        RouteConfig(
          SplashRoute.name,
          path: '/splash',
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
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [MessagesPage]
class MessagesRoute extends PageRouteInfo<MessagesRouteArgs> {
  MessagesRoute({
    Key? key,
    String? userId,
    bool? msgRead,
    String? currentUserDisplayName,
    String? pushToken,
    String? groupChatId,
    bool? isFromContactsPage,
    String? userName,
    String? userPhotoUrl,
  }) : super(
          MessagesRoute.name,
          path: '/messages',
          args: MessagesRouteArgs(
            key: key,
            userId: userId,
            msgRead: msgRead,
            currentUserDisplayName: currentUserDisplayName,
            pushToken: pushToken,
            groupChatId: groupChatId,
            isFromContactsPage: isFromContactsPage,
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
    this.msgRead,
    this.currentUserDisplayName,
    this.pushToken,
    this.groupChatId,
    this.isFromContactsPage,
    this.userName,
    this.userPhotoUrl,
  });

  final Key? key;

  final String? userId;

  final bool? msgRead;

  final String? currentUserDisplayName;

  final String? pushToken;

  final String? groupChatId;

  final bool? isFromContactsPage;

  final String? userName;

  final String? userPhotoUrl;

  @override
  String toString() {
    return 'MessagesRouteArgs{key: $key, userId: $userId, msgRead: $msgRead, currentUserDisplayName: $currentUserDisplayName, pushToken: $pushToken, groupChatId: $groupChatId, isFromContactsPage: $isFromContactsPage, userName: $userName, userPhotoUrl: $userPhotoUrl}';
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
