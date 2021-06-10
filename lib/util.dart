import 'package:intl/intl.dart';
import 'package:woke_out/model/challenge_model.dart';
import 'package:dvhcvn/dvhcvn.dart';

String durationToString(int seconds) {
  var duration = Duration(seconds: seconds);

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  if (duration.inHours == 0) {
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

String datetimeToString(DateTime date) {
  final dateFormat = new DateFormat('MMMM dd, yyyy hh:mm aaa');

  return dateFormat.format(date);
}

ChallengeModel findSecondBestRecord(List<ChallengeModel> challengeList) {
  if (challengeList.isEmpty) {
    return null;
  }

  ChallengeModel bestRecord = challengeList[0];

  for (var element in challengeList) {
    if (element.time < bestRecord.time) {
      return element;
    }
  }

  return null;
}

extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}
