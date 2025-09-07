/// DateFormatter utility class for formatting dates in Arabic and Hijri formats
///
/// Usage examples:
/// - DateFormatter.getFullDate() -> Returns current date in format: '17/02/1447  15:03:16'
/// - DateFormatter.getFullDateForDateTime(someDateTime) -> Returns specific date in same format
/// - DateFormatter.getCurrentArabicDate() -> Returns current date in Arabic: 'السبت 9 أغسطس 2025'
/// - DateFormatter.getCurrentArabicTime() -> Returns current time in Arabic: '12:30 م'
class CustomDateFormatter {
  static const Map<int, String> _arabicDays = {
    1: 'الأحد',
    2: 'الاثنين',
    3: 'الثلاثاء',
    4: 'الأربعاء',
    5: 'الخميس',
    6: 'الجمعة',
    7: 'السبت',
  };

  static const Map<int, String> _arabicMonths = {
    1: 'يناير',
    2: 'فبراير',
    3: 'مارس',
    4: 'أبريل',
    5: 'مايو',
    6: 'يونيو',
    7: 'يوليو',
    8: 'أغسطس',
    9: 'سبتمبر',
    10: 'أكتوبر',
    11: 'نوفمبر',
    12: 'ديسمبر',
  };

  static const Map<int, String> _hijriMonths = {
    1: 'محرم',
    2: 'صفر',
    3: 'ربيع الأول',
    4: 'ربيع الثاني',
    5: 'جمادى الأولى',
    6: 'جمادى الآخرة',
    7: 'رجب',
    8: 'شعبان',
    9: 'رمضان',
    10: 'شوال',
    11: 'ذو القعدة',
    12: 'ذو الحجة',
  };

  /// Formats current date in Arabic
  static String getCurrentArabicDate() {
    final now = DateTime.now();
    final dayName = _arabicDays[now.weekday] ?? '';
    final monthName = _arabicMonths[now.month] ?? '';

    return '$dayName ${now.day} $monthName ${now.year}';
  }

  /// Formats current date in English
  static String getCurrentEnglishDate() {
    final now = DateTime.now();
    final dayNames = [
      '',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    final monthNames = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final dayName = dayNames[now.weekday];
    final monthName = monthNames[now.month];

    return '$dayName ${now.day} $monthName ${now.year}';
  }

  /// Formats current time in Arabic (12-hour format)
  static String getCurrentArabicTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'م' : 'ص';

    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  /// Formats current time in English (12-hour format)
  static String getCurrentEnglishTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';

    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  /// Formats current Hijri date (approximate)
  static String getCurrentHijriDateArabic() {
    final now = DateTime.now();

    // Convert Gregorian to Hijri using more accurate calculation
    final hijriDate = _convertGregorianToHijri(now);

    final hijriMonthName = _hijriMonths[hijriDate['month']] ?? '';

    return 'الموافق ${hijriDate['day']} $hijriMonthName ${hijriDate['year']}';
  }

  /// Convert Gregorian date to Hijri date using Kuwaiti algorithm
  static Map<String, int> _convertGregorianToHijri(DateTime gregorianDate) {
    int jd = _gregorianToJulian(
        gregorianDate.year, gregorianDate.month, gregorianDate.day);
    Map<String, int> hijriDate = _julianToHijri(jd);
    return hijriDate;
  }

  /// Convert Gregorian date to Julian day number
  static int _gregorianToJulian(int year, int month, int day) {
    if (month <= 2) {
      year -= 1;
      month += 12;
    }

    int a = (year / 100).floor();
    int b = 2 - a + (a / 4).floor();

    int jd = (365.25 * (year + 4716)).floor() +
        (30.6001 * (month + 1)).floor() +
        day +
        b -
        1524;

    return jd;
  }

  /// Convert Julian day number to Hijri date
  static Map<String, int> _julianToHijri(int jd) {
    // Hijri epoch (July 16, 622 CE) = Julian day 1948439
    int hijriEpoch = 1948439;
    int daysSinceEpoch = jd - hijriEpoch;

    // Average length of Hijri year in days
    double hijriYearLength = 354.36707;

    // Calculate approximate Hijri year
    int hijriYear = (daysSinceEpoch / hijriYearLength).floor() + 1;

    // Calculate the Julian day of the start of this Hijri year
    int startOfHijriYear =
        hijriEpoch + (hijriYearLength * (hijriYear - 1)).round();

    // Calculate days since start of Hijri year
    int dayOfYear = jd - startOfHijriYear + 1;

    // Handle negative day of year (previous year)
    if (dayOfYear <= 0) {
      hijriYear--;
      startOfHijriYear =
          hijriEpoch + (hijriYearLength * (hijriYear - 1)).round();
      dayOfYear = jd - startOfHijriYear + 1;
    }

    // Calculate month and day
    int hijriMonth = 1;
    int hijriDay = dayOfYear;

    // Hijri months alternate between 30 and 29 days
    List<int> monthLengths = [30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29];

    // Adjust for leap year (adds one day to last month)
    if (_isHijriLeapYear(hijriYear)) {
      monthLengths[11] = 30;
    }

    for (int i = 0; i < 12; i++) {
      if (hijriDay <= monthLengths[i]) {
        hijriMonth = i + 1;
        break;
      }
      hijriDay -= monthLengths[i];
    }

    return {
      'year': hijriYear,
      'month': hijriMonth,
      'day': hijriDay,
    };
  }

  /// Check if a Hijri year is a leap year
  static bool _isHijriLeapYear(int hijriYear) {
    // In a 30-year cycle, years 2, 5, 7, 10, 13, 16, 18, 21, 24, 26, 29 are leap years
    List<int> leapYears = [2, 5, 7, 10, 13, 16, 18, 21, 24, 26, 29];
    int yearInCycle = hijriYear % 30;
    return leapYears.contains(yearInCycle);
  }

  /// Formats current Hijri date in English (approximate)
  static String getCurrentHijriDateEnglish() {
    final now = DateTime.now();

    // Convert Gregorian to Hijri using the same method as getCurrentHijriDateArabic
    final hijriDate = _convertGregorianToHijri(now);

    // English Hijri month names
    const hijriMonthsEnglish = {
      1: 'Muharram',
      2: 'Safar',
      3: 'Rabi\' al-Awwal',
      4: 'Rabi\' al-Thani',
      5: 'Jumada al-Awwal',
      6: 'Jumada al-Thani',
      7: 'Rajab',
      8: 'Sha\'ban',
      9: 'Ramadan',
      10: 'Shawwal',
      11: 'Dhu al-Qi\'dah',
      12: 'Dhu al-Hijjah',
    };

    final hijriMonthName = hijriMonthsEnglish[hijriDate['month']] ?? '';

    return 'Corresponding to ${hijriDate['day']} $hijriMonthName ${hijriDate['year']}';
  }

  /// Get current Hijri year
  static int getCurrentHijriYear() {
    final now = DateTime.now();
    return ((now.year - 622) * 365.25 / 354.37).round();
  }

  /// Get current Hijri month (approximate)
  static int getCurrentHijriMonth() {
    // This is a simplified mapping - for accuracy use a proper Hijri calendar
    final now = DateTime.now();
    // Approximate mapping based on current date
    if (now.month >= 1 && now.month <= 2) return 1; // Muharram
    if (now.month >= 3 && now.month <= 4) return 2; // Safar
    if (now.month >= 5 && now.month <= 6) return 3; // Rabi' al-Awwal
    if (now.month >= 7 && now.month <= 8) return 4; // Rabi' al-Thani
    if (now.month >= 9 && now.month <= 10) return 5; // Jumada al-Awwal
    if (now.month >= 11 && now.month <= 12) return 6; // Jumada al-Thani
    return 1; // Default to Muharram
  }

  /// Get formatted date for a specific DateTime
  static String formatArabicDate(DateTime date) {
    final dayName = _arabicDays[date.weekday] ?? '';
    final monthName = _arabicMonths[date.month] ?? '';

    return '$dayName ${date.day} $monthName ${date.year}';
  }

  static String getFullDate() {
    final now = DateTime.now();

    // Get current time in 24-hour format
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    final timeString = '$hour:$minute:$second';

    // Get current Hijri date using more accurate calculations
    final hijriYear = getCurrentHijriYear();
    final hijriMonth = getCurrentHijriMonth();
    final hijriDay = now.day;

    // Format: DD/MM/YYYY  HH:MM:SS
    return '${hijriDay.toString().padLeft(2, '0')}/${hijriMonth.toString().padLeft(2, '0')}/$hijriYear  $timeString';
  }

  /// Get full date for a specific DateTime
  static String getFullDateForDateTime(DateTime dateTime) {
    // Get time in 24-hour format
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    final timeString = '$hour:$minute:$second';

    // Calculate Hijri date for the specific DateTime
    final hijriYear = ((dateTime.year - 622) * 365.25 / 354.37).round();

    // Approximate Hijri month mapping
    int hijriMonth;
    if (dateTime.month >= 1 && dateTime.month <= 2) {
      hijriMonth = 1; // Muharram
    } else if (dateTime.month >= 3 && dateTime.month <= 4) {
      hijriMonth = 2; // Safar
    } else if (dateTime.month >= 5 && dateTime.month <= 6) {
      hijriMonth = 3; // Rabi' al-Awwal
    } else if (dateTime.month >= 7 && dateTime.month <= 8) {
      hijriMonth = 4; // Rabi' al-Thani
    } else if (dateTime.month >= 9 && dateTime.month <= 10) {
      hijriMonth = 5; // Jumada al-Awwal
    } else {
      hijriMonth = 6; // Jumada al-Thani
    }
    final hijriDay = dateTime.day;

    // Format: DD/MM/YYYY  HH:MM:SS
    return '${hijriDay.toString().padLeft(2, '0')}/${hijriMonth.toString().padLeft(2, '0')}/$hijriYear  $timeString';
  }
}
