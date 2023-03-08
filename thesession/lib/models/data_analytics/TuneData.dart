// To parse this JSON data, do
//
//     final tuneData = tuneDataFromJson(jsonString);

import 'dart:convert';

TuneDataDump tuneDataFromJson(String str) =>
    TuneDataDump.fromJson(json.decode(str));

String tuneDataToJson(TuneDataDump data) => json.encode(data.toJson());

class TuneDataDump {
  TuneDataDump({
    required this.tunes,
  });

  List<TuneData> tunes;

  factory TuneDataDump.fromJson(Map<String, dynamic> json) => TuneDataDump(
        tunes:
            List<TuneData>.from(json["tunes"].map((x) => TuneData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tunes": List<dynamic>.from(tunes.map((x) => x.toJson())),
      };
}

class TuneData {
  TuneData({
    required this.tuneId,
    required this.settingId,
    required this.name,
    required this.type,
    required this.meter,
    required this.mode,
    required this.abc,
    this.date,
    this.username,
  });

  String tuneId;
  String settingId;
  String name;
  Type type;
  Meter meter;
  Mode mode;
  String abc;
  DateTime? date;
  String? username;

  factory TuneData.fromJson(Map<String, dynamic> json) => TuneData(
        tuneId: json["tune_id"],
        settingId: json["setting_id"],
        name: json["name"],
        type: typeValues.map[json["type"]]!,
        meter: meterValues.map[json["meter"]]!,
        mode: modeValues.map[json["mode"]]!,
        abc: json["abc"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "tune_id": tuneId,
        "setting_id": settingId,
        "name": name,
        "type": typeValues.reverse[type],
        "meter": meterValues.reverse[meter],
        "mode": modeValues.reverse[mode],
        "abc": abc,
        "date": date?.toIso8601String(),
        "username": username,
      };
}

enum Meter { THE_24, THE_98, THE_44, THE_68, THE_34, THE_32, THE_128 }

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
  GMAJOR,
  BMINOR,
  DMAJOR,
  DDORIAN,
  AMIXOLYDIAN,
  EMINOR,
  EDORIAN,
  DMIXOLYDIAN,
  EMAJOR,
  ADORIAN,
  GMINOR,
  DMINOR,
  FMAJOR,
  AMAJOR,
  GDORIAN,
  AMINOR,
  CMAJOR,
  FDORIAN,
  EMIXOLYDIAN,
  BMIXOLYDIAN,
  GMIXOLYDIAN,
  CDORIAN,
  BDORIAN
}

final modeValues = EnumValues({
  "Adorian": Mode.ADORIAN,
  "Amajor": Mode.AMAJOR,
  "Aminor": Mode.AMINOR,
  "Amixolydian": Mode.AMIXOLYDIAN,
  "Bdorian": Mode.BDORIAN,
  "Bminor": Mode.BMINOR,
  "Bmixolydian": Mode.BMIXOLYDIAN,
  "Cdorian": Mode.CDORIAN,
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
  POLKA,
  SLIP_JIG,
  STRATHSPEY,
  REEL,
  JIG,
  WALTZ,
  MARCH,
  BARNDANCE,
  MAZURKA,
  THREE_TWO,
  HORNPIPE,
  SLIDE
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
