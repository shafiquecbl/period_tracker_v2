class Event {
  DateTime date;
  int predictedDay = 0;
  int cycleday = 0;

  Event({
    required this.date,
    this.predictedDay = 0,
    this.cycleday = 0,
  });

  // to json
  Map<String, dynamic> toJson() => {
        'date': date,
        'predictedDay': predictedDay,
        'cycleday': cycleday,
      };
}
