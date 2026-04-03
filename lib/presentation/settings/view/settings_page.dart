import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/provider/profile_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 시스템 설정에서 돌아왔을 때 알림 상태 재확인
      ref
          .read(notificationSettingNotifierProvider.notifier)
          .checkSystemStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationEnabled = ref.watch(notificationSettingNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: const Text(
          AppStrings.settingsTitle,
          style: AppTextStyles.username,
        ),
        centerTitle: true,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          // 알림 설정
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: AppStrings.settingsNotification,
            subtitle: AppStrings.settingsNotificationDescription,
            trailing: Switch.adaptive(
              value: notificationEnabled,
              onChanged: (_) {
                ref.read(notificationSettingNotifierProvider.notifier).toggle();
              },
              activeTrackColor: AppColors.primary,
            ),
          ),
          const _Divider(),
          // 권한 관리
          _SettingsTile(
            icon: Icons.security_outlined,
            title: AppStrings.settingsPermission,
            subtitle: AppStrings.settingsPermissionDescription,
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.whiteSecondary,
            ),
            onTap: () => openAppSettings(),
          ),
          const _Divider(),
          // 앱 버전
          const _SettingsTile(
            icon: Icons.info_outline,
            title: AppStrings.settingsVersion,
            subtitle: AppStrings.appVersion,
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.white, size: 24),
      title: Text(title, style: AppTextStyles.description),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.profileLabel.copyWith(
          color: AppColors.whiteSecondary,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: AppColors.divider, height: 1),
    );
  }
}
