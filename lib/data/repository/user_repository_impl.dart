import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:kwon_tiktoc_clone/data/model/user_model.dart';
import 'package:kwon_tiktoc_clone/domain/entity/user.dart';
import 'package:kwon_tiktoc_clone/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  static const _baseUrl = 'https://api.myfortie.com';
  static const _currentUserId = 'current_user';

  static final _mockUsers = <String, UserModel>{
    _currentUserId: const UserModel(
      id: _currentUserId,
      nickname: '나의계정',
      isVerified: false,
      followingCount: 128,
      followerCount: 1542,
      likeCount: 8700,
    ),
    'user_1': const UserModel(
      id: 'user_1',
      nickname: 'dance_queen',
      isVerified: true,
      followingCount: 320,
      followerCount: 5500000,
      likeCount: 89000000,
    ),
    'user_2': const UserModel(
      id: 'user_2',
      nickname: 'travel_diary',
      isVerified: true,
      followingCount: 156,
      followerCount: 2300000,
      likeCount: 45000000,
    ),
    'user_3': const UserModel(
      id: 'user_3',
      nickname: 'cooking_master',
      isVerified: true,
      followingCount: 89,
      followerCount: 1800000,
      likeCount: 32000000,
    ),
    'user_4': const UserModel(
      id: 'user_4',
      nickname: 'pet_lover',
      isVerified: false,
      followingCount: 245,
      followerCount: 980000,
      likeCount: 15000000,
    ),
    'user_5': const UserModel(
      id: 'user_5',
      nickname: 'fitness_pro',
      isVerified: true,
      followingCount: 67,
      followerCount: 3200000,
      likeCount: 56000000,
    ),
    'user_6': const UserModel(
      id: 'user_6',
      nickname: 'comedy_king',
      isVerified: true,
      followingCount: 412,
      followerCount: 8900000,
      likeCount: 120000000,
    ),
    'user_7': const UserModel(
      id: 'user_7',
      nickname: 'music_vibes',
      isVerified: false,
      followingCount: 198,
      followerCount: 750000,
      likeCount: 9800000,
    ),
    'user_8': const UserModel(
      id: 'user_8',
      nickname: 'art_studio',
      isVerified: false,
      followingCount: 134,
      followerCount: 620000,
      likeCount: 7500000,
    ),
    'user_9': const UserModel(
      id: 'user_9',
      nickname: 'nature_walk',
      isVerified: false,
      followingCount: 78,
      followerCount: 430000,
      likeCount: 5200000,
    ),
    'user_10': const UserModel(
      id: 'user_10',
      nickname: 'street_food',
      isVerified: true,
      followingCount: 267,
      followerCount: 4100000,
      likeCount: 67000000,
    ),
    'user_11': const UserModel(
      id: 'user_11',
      nickname: 'yoga_life',
      isVerified: false,
      followingCount: 145,
      followerCount: 890000,
      likeCount: 11000000,
    ),
    'user_12': const UserModel(
      id: 'user_12',
      nickname: 'skate_tricks',
      isVerified: false,
      followingCount: 312,
      followerCount: 1500000,
      likeCount: 23000000,
    ),
    'user_13': const UserModel(
      id: 'user_13',
      nickname: 'sunset_chaser',
      isVerified: false,
      followingCount: 201,
      followerCount: 670000,
      likeCount: 8100000,
    ),
  };

  @override
  Future<User> getUserById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final model = _mockUsers[id];
    if (model == null) throw Exception('User not found: $id');
    return model.toEntity();
  }

  @override
  Future<User> getCurrentUser() async {
    return getUserById(_currentUserId);
  }

  @override
  Future<List<User>> getRecommendedUsers() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return _mockUsers.entries
        .where((e) => e.key != _currentUserId)
        .map((e) => e.value.toEntity())
        .toList();
  }

  @override
  Future<String?> getProfileImageUrl(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/videos/profile-image/$userId'),
      );

      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final url = json['profileImageUrl'] as String?;
      return url;
    } catch (e) {
      debugPrint('프로필 이미지 조회 실패: $e');
      return null;
    }
  }

  @override
  Future<String> uploadProfileImage({
    required String imagePath,
    required String userId,
  }) async {
    final uri = Uri.parse('$_baseUrl/videos/profile-image/upload');
    final request = http.MultipartRequest('POST', uri);

    request.fields['userId'] = userId;
    request.files.add(
      await http.MultipartFile.fromPath('image', imagePath),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('프로필 이미지 업로드 실패: ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final profileImageUrl = json['profileImageUrl'] as String?;

    if (profileImageUrl == null) {
      throw Exception('프로필 이미지 URL이 응답에 없습니다');
    }

    debugPrint('프로필 이미지 업로드 완료: $profileImageUrl');
    return profileImageUrl;
  }
}
