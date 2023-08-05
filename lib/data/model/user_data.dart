class UserData {
  int? cycleLength;
  int? periodLength;
  DateTime? lastPeriodDate;

  UserData({
    required this.cycleLength,
    required this.periodLength,
    required this.lastPeriodDate,
  });

  UserData copyWith({
    int? cycleLength,
    int? periodLength,
    DateTime? lastPeriodDate,
  }) {
    return UserData(
      cycleLength: cycleLength ?? this.cycleLength,
      periodLength: periodLength ?? this.periodLength,
      lastPeriodDate: lastPeriodDate ?? this.lastPeriodDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cycleLength': cycleLength,
      'periodLength': periodLength,
      'lastPeriodDate': lastPeriodDate,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      cycleLength: map['cycleLength'],
      periodLength: map['periodLength'],
      lastPeriodDate: map['lastPeriodDate'],
    );
  }
}
