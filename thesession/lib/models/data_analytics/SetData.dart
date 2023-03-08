// To parse this JSON data, do
//
//     final seDataDump = seDataDumpFromJson(jsonString);

import 'dart:convert';

SeDataDump seDataDumpFromJson(String str) =>
    SeDataDump.fromJson(json.decode(str));

String seDataDumpToJson(SeDataDump data) => json.encode(data.toJson());

class SeDataDump {
  SeDataDump({
    required this.sets,
  });

  List<Set> sets;

  factory SeDataDump.fromJson(Map<String, dynamic> json) => SeDataDump(
        sets: List<Set>.from(json["sets"].map((x) => Set.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sets": List<dynamic>.from(sets.map((x) => x.toJson())),
      };
}

class Set {
  Set({
    required this.tuneset,
    required this.date,
    required this.memberId,
    required this.username,
    required this.settingorder,
    required this.name,
    required this.tuneId,
    required this.settingId,
    required this.type,
    required this.meter,
    required this.mode,
    required this.abc,
  });

  String tuneset;
  DateTime date;
  String memberId;
  String username;
  String settingorder;
  String name;
  String tuneId;
  String settingId;
  Type type;
  Meter meter;
  Mode mode;
  String abc;

  factory Set.fromJson(Map<String, dynamic> json) => Set(
        tuneset: json["tuneset"],
        date: DateTime.parse(json["date"]),
        memberId: json["member_id"],
        username: json["username"],
        settingorder: json["settingorder"],
        name: json["name"],
        tuneId: json["tune_id"],
        settingId: json["setting_id"],
        type: typeValues.map[json["type"]]!,
        meter: meterValues.map[json["meter"]]!,
        mode: modeValues.map[json["mode"]]!,
        abc: json["abc"],
      );

  Map<String, dynamic> toJson() => {
        "tuneset": tuneset,
        "date": date.toIso8601String(),
        "member_id": memberId,
        "username": username,
        "settingorder": settingorder,
        "name": name,
        "tune_id": tuneId,
        "setting_id": settingId,
        "type": typeValues.reverse[type],
        "meter": meterValues.reverse[meter],
        "mode": modeValues.reverse[mode],
        "abc": abc,
      };
}

enum Meter { THE_44, THE_68, THE_34, THE_24, THE_128, THE_32, THE_98 }

final meterValues = EnumValues({
  "12/8": Meter.THE_128,
  "2/4": Meter.THE_24,
  "3/2": Meter.THE_32,
  "3/4": Meter.THE_34,
  "4/4": Meter.THE_44,
  "6/8": Meter.THE_68,
  "9/8": Meter.THE_98
});

enum Mode {
  EDORIAN,
  GMAJOR,
  DMAJOR,
  AMIXOLYDIAN,
  CMAJOR,
  DMIXOLYDIAN,
  EMINOR,
  AMAJOR,
  ADORIAN,
  DMINOR,
  FMAJOR,
  DDORIAN,
  GMIXOLYDIAN,
  GDORIAN,
  EMAJOR,
  AMINOR,
  BMINOR,
  GMINOR,
  BDORIAN,
  FDORIAN,
  EMIXOLYDIAN
}

final modeValues = EnumValues({
  "Adorian": Mode.ADORIAN,
  "Amajor": Mode.AMAJOR,
  "Aminor": Mode.AMINOR,
  "Amixolydian": Mode.AMIXOLYDIAN,
  "Bdorian": Mode.BDORIAN,
  "Bminor": Mode.BMINOR,
  "Cmajor": Mode.CMAJOR,
  "Ddorian": Mode.DDORIAN,
  "Dmajor": Mode.DMAJOR,
  "Dminor": Mode.DMINOR,
  "Dmixolydian": Mode.DMIXOLYDIAN,
  "Edorian": Mode.EDORIAN,
  "Emajor": Mode.EMAJOR,
  "Eminor": Mode.EMINOR,
  "Emixolydian": Mode.EMIXOLYDIAN,
  "Fdorian": Mode.FDORIAN,
  "Fmajor": Mode.FMAJOR,
  "Gdorian": Mode.GDORIAN,
  "Gmajor": Mode.GMAJOR,
  "Gminor": Mode.GMINOR,
  "Gmixolydian": Mode.GMIXOLYDIAN
});

enum Type {
  REEL,
  JIG,
  WALTZ,
  MARCH,
  POLKA,
  HORNPIPE,
  SLIDE,
  THREE_TWO,
  MAZURKA,
  STRATHSPEY,
  SLIP_JIG,
  BARNDANCE
}

final typeValues = EnumValues({
  "barndance": Type.BARNDANCE,
  "hornpipe": Type.HORNPIPE,
  "jig": Type.JIG,
  "march": Type.MARCH,
  "mazurka": Type.MAZURKA,
  "polka": Type.POLKA,
  "reel": Type.REEL,
  "slide": Type.SLIDE,
  "slip jig": Type.SLIP_JIG,
  "strathspey": Type.STRATHSPEY,
  "three-two": Type.THREE_TWO,
  "waltz": Type.WALTZ
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
