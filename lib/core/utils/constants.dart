class AppConstants {
  static const String appName = 'Creator Growth';
  static List<String> get niches => [
        'Gaming',
        'Technology',
        'AI',
        'Programming',
        'Business',
        'Finance',
        'Education',
        'Travel',
        'Photography',
        'Lifestyle',
        'Fitness',
        'Food',
        'Marketing',
        'Freelancing',
        'E-Commerce',
        'Other'
      ];
  static List<String> get platforms =>
      ['YouTube', 'Instagram', 'TikTok', 'Facebook', 'LinkedIn', 'X (Twitter)'];
  static List<String> get taskTypes => [
        'Watch Video',
        'Watch Reel',
        'Watch Short',
        'View Image',
        'Visit Profile',
        'Follow User',
        'Like Post',
        'Comment on Post'
      ];
  static List<String> get taskCategories =>
      ['Growth', 'Engagement', 'Promotion', 'Research', 'Review'];
  static List<String> get countries => [
        'All Countries',
        'United States',
        'United Kingdom',
        'Canada',
        'Australia',
        'India',
        'Pakistan'
      ];
  static List<String> get communityCategories => [
        'YouTube',
        'TikTok',
        'Instagram',
        'Facebook',
        'Freelancing',
        'Business',
        'AI',
        'Technology'
      ];
}

class CreatorLevel {
  static String getLevelFromPoints(int points) {
    if (points >= 10000) return 'Elite Creator';
    if (points >= 5000) return 'Growth Master';
    if (points >= 2000) return 'Creator Pro';
    if (points >= 500) return 'Rising Creator';
    return 'Beginner';
  }
}
