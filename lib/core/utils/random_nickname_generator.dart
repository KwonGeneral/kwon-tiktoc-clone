import 'dart:math';

abstract final class RandomNicknameGenerator {
  static const _adjectives = [
    '귀여운',
    '빠른',
    '행복한',
    '용감한',
    '똑똑한',
    '재미있는',
    '멋진',
    '착한',
    '신나는',
    '따뜻한',
    '반짝이는',
    '깜찍한',
    '씩씩한',
    '활발한',
    '영리한',
    '다정한',
    '든든한',
    '상냥한',
    '발랄한',
    '당당한',
  ];

  static const _nouns = [
    '고양이',
    '강아지',
    '토끼',
    '판다',
    '호랑이',
    '사자',
    '펭귄',
    '코알라',
    '여우',
    '다람쥐',
    '햄스터',
    '수달',
    '오리',
    '부엉이',
    '돌고래',
    '당근',
    '감자',
    '옥수수',
    '딸기',
    '수박',
  ];

  static const _adjectivesEn = [
    'cute',
    'fast',
    'happy',
    'brave',
    'smart',
    'funny',
    'cool',
    'kind',
    'bright',
    'warm',
    'shiny',
    'sweet',
    'bold',
    'lively',
    'clever',
    'gentle',
    'steady',
    'soft',
    'fresh',
    'proud',
  ];

  static const _nounsEn = [
    'cat',
    'dog',
    'rabbit',
    'panda',
    'tiger',
    'lion',
    'penguin',
    'koala',
    'fox',
    'squirrel',
    'hamster',
    'otter',
    'duck',
    'owl',
    'dolphin',
    'carrot',
    'potato',
    'corn',
    'strawberry',
    'watermelon',
  ];

  static final _random = Random();

  /// 랜덤 닉네임 생성: "귀여운고양이#3847"
  static String generateNickname() {
    final adj = _adjectives[_random.nextInt(_adjectives.length)];
    final noun = _nouns[_random.nextInt(_nouns.length)];
    final number = _random.nextInt(9000) + 1000; // 1000~9999
    return '$adj$noun#$number';
  }

  /// 랜덤 username 생성: "cute_cat_3847"
  static String generateUsername() {
    final adj = _adjectivesEn[_random.nextInt(_adjectivesEn.length)];
    final noun = _nounsEn[_random.nextInt(_nounsEn.length)];
    final number = _random.nextInt(9000) + 1000;
    return '${adj}_${noun}_$number';
  }
}
