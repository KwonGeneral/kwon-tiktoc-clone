import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:kwon_tiktoc_clone/domain/entity/post_image.dart';
import 'package:kwon_tiktoc_clone/presentation/camera/view/camera_page.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/view/feed_page.dart';
import 'package:kwon_tiktoc_clone/presentation/friends/view/friends_page.dart';
import 'package:kwon_tiktoc_clone/presentation/image_detail/view/image_detail_page.dart';
import 'package:kwon_tiktoc_clone/presentation/main/main_shell.dart';
import 'package:kwon_tiktoc_clone/presentation/notifications/view/notifications_page.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/view/profile_edit_page.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/view/profile_page.dart';
import 'package:kwon_tiktoc_clone/presentation/publish/view/publish_image_page.dart';
import 'package:kwon_tiktoc_clone/presentation/publish/view/publish_page.dart';
import 'package:kwon_tiktoc_clone/presentation/settings/view/settings_page.dart';
import 'package:kwon_tiktoc_clone/presentation/user_profile/view/user_profile_page.dart';
import 'route_paths.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: RoutePaths.feed,
    routes: [
      // 유저 프로필 (ShellRoute 밖 — 하단 네비 없음)
      GoRoute(
        path: RoutePaths.userProfile,
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return UserProfilePage(userId: userId);
        },
      ),
      // 카메라 (ShellRoute 밖 — 전체 화면)
      GoRoute(
        path: RoutePaths.camera,
        builder: (context, state) => const CameraPage(),
      ),
      // 게시 (ShellRoute 밖 — 전체 화면)
      GoRoute(
        path: RoutePaths.publish,
        builder: (context, state) {
          final filePath = state.uri.queryParameters['filePath'] ?? '';
          return PublishPage(videoFilePath: filePath);
        },
      ),
      // 이미지 게시 (ShellRoute 밖 — 전체 화면)
      GoRoute(
        path: RoutePaths.publishImage,
        builder: (context, state) {
          final filePath = state.uri.queryParameters['filePath'] ?? '';
          return PublishImagePage(imageFilePath: filePath);
        },
      ),
      // 이미지 상세 보기
      GoRoute(
        path: RoutePaths.imageDetail,
        builder: (context, state) {
          final postImage = state.extra as PostImage;
          return ImageDetailPage(postImage: postImage);
        },
      ),
      // 프로필 편집
      GoRoute(
        path: RoutePaths.profileEdit,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>? ?? {};
          return ProfileEditPage(
            initialNickname: extra['nickname'] ?? '',
            initialBio: extra['bio'] ?? '',
          );
        },
      ),
      // 설정
      GoRoute(
        path: RoutePaths.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.feed,
                builder: (context, state) => const FeedPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.friends,
                builder: (context, state) => const FriendsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.discover,
                builder: (context, state) => const SizedBox.shrink(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.notifications,
                builder: (context, state) => const NotificationsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
