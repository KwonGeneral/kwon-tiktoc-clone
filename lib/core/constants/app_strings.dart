abstract final class AppStrings {
  // Feed 탭
  static const feedTabFollowing = '팔로잉';
  static const feedTabRecommend = '추천';

  // 영상 설명
  static const descriptionMore = '...더보기';

  // 하단 네비게이션
  static const navHome = '홈';
  static const navFriends = '친구';
  static const navNotifications = '알림';
  static const navProfile = '프로필';

  // 빈 상태
  static const feedEmpty = '영상이 없습니다';
  static const feedError = '영상을 불러올 수 없습니다';
  static const feedRetry = '다시 시도';
  static const feedLoadMoreError = '탭하여 다시 불러오기';
  static const feedFollowingEmpty =
      '팔로잉한 사람의 영상이 없습니다.\n추천 탭에서 크리에이터를 팔로우해보세요!';

  // 프로필
  static const profileEdit = '편집';
  static const profileFollowing = '팔로잉';
  static const profileFollowers = '팔로워';
  static const profileLikes = '좋아요';
  static const profileAddBio = '+ 자기소개 추가';
  static const profileInterests = '제 관심사는...';
  static const profileEmptyVideos = '추억의 동영상을 공유하세요';
  static const profileUpload = '업로드';

  // 댓글
  static const commentTitle = '댓글';
  static const commentTitleWithCount = '댓글 {count}개';
  static const commentInputHint = '따뜻한 말 한마디 해주세요...';
  static const commentEmpty = '아직 댓글이 없습니다.\n첫 댓글을 남겨보세요!';
  static const commentCurrentUserName = '나';
  static const commentReply = '답글';
  static const commentShowReplies = '답글 {count}개 더보기';
  static const commentHideReplies = '답글 숨기기';
  static const commentReplyingTo = '{name}님에게 답글 남기는 중';
  static const commentJustNow = '방금';
  static const commentMinutesAgo = '{m}분 전';
  static const commentHoursAgo = '{h}시간 전';
  static const commentDaysAgo = '{d}일 전';

  // 공유
  static const shareText = '{nickname}님의 영상을 확인해보세요!';

  // 유저 프로필
  static const userProfileFollow = '팔로우';
  static const userProfileFollowing = '팔로잉';
  static const userProfileMessage = '메시지';

  // 친구
  static const friendsTitle = '친구';
  static const friendsBanner = '친구를 팔로우하여\n동영상을 시청하세요';
  static const friendsFindFacebook = 'Facebook 친구';
  static const friendsFindFacebookSub = '친구 찾기';
  static const friendsFindButton = '찾기';
  static const friendsFollow = '팔로우';
  static const friendsFollowing = '팔로잉';
  static const friendsRemove = '제거';
  static const friendsMutualFollow = '맞팔로우 중: ';
  static const friendsFollowedBy = '팔로우된 친구: ';
  static const friendsSearchHint = '검색';
  static const friendsEmpty = '추천 친구가 없습니다';

  // 카메라
  static const cameraNotAvailable = '사용 가능한 카메라가 없습니다';
  static const cameraInitError = '카메라를 초기화할 수 없습니다';
  static const cameraGoBack = '돌아가기';
  static const cameraDeleteClipTitle = '클립 삭제';
  static const cameraDeleteClipMessage = '마지막 클립을 삭제할까요?';
  static const cameraCancel = '취소';
  static const cameraDelete = '삭제';
  static const cameraConfirm = '확인';
  static const cameraRecordingComplete = '촬영 완료';
  static const cameraRecordingCompleteMessage = '게시 기능은 다음 Phase에서 구현됩니다.';
  static const cameraVideoMode = '동영상';

  // 게시
  static const publishTitle = '게시';
  static const publishDescriptionHint = '설명을 추가하세요...';

  static const publishHashtag = '# 해시태그';
  static const publishMention = '@ 멘션';
  static const publishLocation = '위치';
  static const publishAddLink = '링크 추가';
  static const publishVisibility = '팔로워만 이 게시물을 볼 수 있습니다';
  static const publishAdvancedSettings = '고급 설정';
  static const publishShare = '공유';
  static const publishButton = '게시';
  static const publishPrivacyTitle = '개인정보 안내';
  static const publishPrivacyMessage =
      '이 영상은 실제로 서버에 업로드됩니다. 개인정보가 포함되지 않았는지 확인해주세요.';
  static const publishPrivacyCancel = '취소';
  static const publishPrivacyConfirm = '게시';
  static const publishCompressing = '영상 압축 중...';
  static const publishUploading = '업로드 중...';
  static const publishSuccess = '업로드 완료!';
  static const publishFailed = '업로드에 실패했습니다';
  static const publishRetry = '다시 시도';

  // 알림
  static const notificationsTitle = '알림';
  static const notificationsNewFollowers = '새 팔로워';
  static const notificationsNewFollowersSub = '여기에서 새 팔로워를 확인하세요.';
  static const notificationsActivity = '활동';
  static const notificationsActivitySub = '여기에서 알림을 확인하세요.';
  static const notificationsSystem = '시스템 알림';
  static const notificationsRecommendedAccounts = '추천 계정';
  static const notificationsEmpty = '아직 알림이 없습니다';
  static const notificationsFilterEmpty = '알림이 없습니다';
  static const notificationsShowAll = '전체 보기';

  // 프로필 이미지
  static const profileImageTitle = '프로필 사진 변경';
  static const profileImageGallery = '앨범에서 선택';
  static const profileImageCamera = '사진 촬영';
  static const profileImageCancel = '취소';
  static const profileImageUploading = '업로드 중...';
  static const profileImageUploadFailed = '프로필 사진 업로드에 실패했습니다';
  static const profileEditChangePhoto = '사진 변경';

  // 프로필 편집
  static const profileEditTitle = '프로필 편집';
  static const profileEditNickname = '닉네임';
  static const profileEditNicknameHint = '닉네임을 입력하세요';
  static const profileEditBioTitle = '자기소개';
  static const profileEditBioDescription = '자기소개는 언제든지 편집할 수 있습니다.';
  static const profileEditBioHint = '제 취미는...';
  static const profileEditCancel = '취소';
  static const profileEditSave = '저장';

  // 설정
  static const settingsTitle = '설정';
  static const settingsNotification = '알림 설정';
  static const settingsNotificationDescription = '푸시 알림을 받습니다';
  static const settingsPermission = '권한 관리';
  static const settingsPermissionDescription = '카메라, 마이크 등 앱 권한을 관리합니다';
  static const settingsVersion = '앱 버전';
  static const appVersion = '1.0.0';

  // 프로필 탭 빈 상태
  static const profileEmptyBookmarks = '즐겨찾기 동영상이 여기에 표시됩니다.';
  static const profileEmptyLikes = '내가 \'좋아요\'를 누른 게시물은 내게만\n표시됩니다';
  static const profileEmptyMyVideos = '데일리 루틴을 공유하세요';

  // 업로드 영상
  static const uploadedMusicName = 'Original Sound';

  // 카메라 모드
  static const cameraPhotoMode = '사진';

  // 이미지 게시
  static const publishImageUploading = '이미지 업로드 중...';
  static const publishImageSuccess = '이미지 업로드 완료!';
  static const publishImagePrivacyMessage =
      '이 이미지는 실제로 서버에 업로드됩니다. 개인정보가 포함되지 않았는지 확인해주세요.';
  static const publishCaptionHint = '설명을 추가하세요...';

  // 이미지 상세
  static const imageDetailTitle = '게시물';

  // 프로필 이미지 게시물
  static const profileEmptyPostImages = '아직 이미지 게시물이 없습니다';

  // 팔로잉/팔로워 목록
  static const followListEmptyFollowing = '팔로잉한 유저가 없습니다';
  static const followListEmptyFollowers = '팔로워가 없습니다';

  // Placeholder
  static const placeholderFriends = '친구 기능 준비 중';
  static const placeholderNotifications = '알림 기능 준비 중';
  static const placeholderProfile = '프로필';
  static const placeholderCreate = '촬영 기능 준비 중';
}
