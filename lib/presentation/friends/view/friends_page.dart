import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/friends/provider/friends_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/friends/widget/friend_list_tile.dart';

class FriendsPage extends ConsumerStatefulWidget {
  const FriendsPage({super.key});

  @override
  ConsumerState<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends ConsumerState<FriendsPage> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final friendsAsync = ref.watch(friendsNotifierProvider);
    final followedUserIds =
        ref.watch(feedNotifierProvider).valueOrNull?.followedUserIds ?? {};

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: _isSearching
            ? _SearchField(
                controller: _searchController,
                onChanged: (query) {
                  ref.read(friendsNotifierProvider.notifier).search(query);
                },
                onClose: () {
                  setState(() => _isSearching = false);
                  _searchController.clear();
                  ref.read(friendsNotifierProvider.notifier).search('');
                },
              )
            : const Text(
                AppStrings.friendsTitle,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        leading: _isSearching
            ? null
            : const Padding(
                padding: EdgeInsets.only(left: 16),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.gray,
                  child: Icon(
                    Icons.person,
                    color: AppColors.whiteSecondary,
                    size: 20,
                  ),
                ),
              ),
        actions: _isSearching
            ? null
            : [
                IconButton(
                  icon: const Icon(Icons.search, color: AppColors.white),
                  onPressed: () => setState(() => _isSearching = true),
                ),
              ],
      ),
      body: friendsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.white),
        ),
        error: (e, _) => Center(
          child: Text(
            e.toString(),
            style: const TextStyle(color: AppColors.whiteSecondary),
          ),
        ),
        data: (friendsState) => ListView(
          children: [
            // 배너
            const _Banner(),

            // Facebook 찾기 카드
            const _FindFriendsCard(),

            const Divider(color: AppColors.divider, height: 1),

            // 친구 목록
            if (friendsState.users.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text(
                    AppStrings.friendsEmpty,
                    style: TextStyle(
                      color: AppColors.whiteSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            else
              ...friendsState.users.map(
                (user) => FriendListTile(
                  user: user,
                  isFollowed: followedUserIds.contains(user.id),
                  onToggleFollow: () {
                    ref
                        .read(feedNotifierProvider.notifier)
                        .toggleFollow(user.id);
                  },
                  onRemove: () {
                    ref
                        .read(friendsNotifierProvider.notifier)
                        .removeUser(user.id);
                  },
                ),
              ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onClose,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      style: const TextStyle(color: AppColors.white, fontSize: 16),
      decoration: InputDecoration(
        hintText: AppStrings.friendsSearchHint,
        hintStyle: const TextStyle(color: AppColors.whiteDisabled),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.close,
            color: AppColors.whiteSecondary,
            size: 20,
          ),
          onPressed: onClose,
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Text(
        AppStrings.friendsBanner,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          height: 1.3,
        ),
      ),
    );
  }
}

class _FindFriendsCard extends StatelessWidget {
  const _FindFriendsCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Facebook 아이콘
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.facebookBlue,
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Icon(Icons.facebook, color: AppColors.white, size: 36),
          ),
          const SizedBox(width: 12),

          // 텍스트
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.friendsFindFacebook,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  AppStrings.friendsFindFacebookSub,
                  style: TextStyle(
                    color: AppColors.whiteSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // 찾기 버튼
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 28),
              ),
              child: const Text(
                AppStrings.friendsFindButton,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
