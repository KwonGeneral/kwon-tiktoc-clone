import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../profile/provider/profile_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                if (!notificationEnabled) {
                  // OFF → ON: 시스템 알림 설정으로 이동
                  AppSettings.openAppSettings(
                    type: AppSettingsType.notification,
                  );
                }
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
            onTap: () => AppSettings.openAppSettings(),
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
