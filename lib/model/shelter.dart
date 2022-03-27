class Shelter {
  Shelter({
    required this.bed,
    required this.note,
    required this.countSick,
    required this.lng,
    required this.created,
    required this.food,
    required this.phone,
    required this.name,
    required this.countRefugee,
    required this.countInjury,
    this.picId,
    required this.bathroom,
    required this.lat,
  });
  late final bool bed;
  late final String note;
  late final int countSick;
  late final double lng;
  late final int created;
  late final bool food;
  late final String phone;
  late final String name;
  late final int countRefugee;
  late final int countInjury;
  late final Null picId;
  late final bool bathroom;
  late final double lat;

  Shelter.fromJson(Map<String, dynamic> json) {
    bed = json['bed'];
    note = json['note'];
    countSick = json['count_sick'];
    lng = json['lng'];
    created = json['created'];
    food = json['food'];
    phone = json['phone'];
    name = json['name'];
    countRefugee = json['count_refugee'];
    countInjury = json['count_injury'];
    picId = null;
    bathroom = json['bathroom'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bed'] = bed;
    _data['note'] = note;
    _data['count_sick'] = countSick;
    _data['lng'] = lng;
    _data['created'] = created;
    _data['food'] = food;
    _data['phone'] = phone;
    _data['name'] = name;
    _data['count_refugee'] = countRefugee;
    _data['count_injury'] = countInjury;
    _data['picId'] = picId;
    _data['bathroom'] = bathroom;
    _data['lat'] = lat;
    return _data;
  }
}
