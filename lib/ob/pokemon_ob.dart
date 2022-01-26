class PokemonOb {
  int? num;
  String? name;
  List<Variations>? variations;
  String? link;

  PokemonOb({this.num, this.name, this.variations, this.link});

  PokemonOb.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(Variations.fromJson(v));
      });
    }
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['name'] = name;
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    data['link'] = link;
    return data;
  }
}

class Variations {
  String? name;
  String? description;
  String? image;
  List<String>? types;
  String? specie;
  num? height;
  num? weight;
  List<String>? abilities;
  Stats? stats;
  List<String>? evolutions;

  Variations(
      {this.name,
      this.description,
      this.image,
      this.types,
      this.specie,
      this.height,
      this.weight,
      this.abilities,
      this.stats,
      this.evolutions});

  Variations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
    types = json['types'].cast<String>();
    specie = json['specie'];
    height = json['height'];
    weight = json['weight'];
    abilities = json['abilities'].cast<String>();
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    evolutions = json['evolutions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['types'] = types;
    data['specie'] = specie;
    data['height'] = height;
    data['weight'] = weight;
    data['abilities'] = abilities;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    data['evolutions'] = evolutions;
    return data;
  }
}

class Stats {
  int? total;
  int? hp;
  int? attack;
  int? defense;
  int? speedAttack;
  int? speedDefense;
  int? speed;

  Stats(
      {this.total,
      this.hp,
      this.attack,
      this.defense,
      this.speedAttack,
      this.speedDefense,
      this.speed});

  Stats.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    hp = json['hp'];
    attack = json['attack'];
    defense = json['defense'];
    speedAttack = json['speedAttack'];
    speedDefense = json['speedDefense'];
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['hp'] = hp;
    data['attack'] = attack;
    data['defense'] = defense;
    data['speedAttack'] = speedAttack;
    data['speedDefense'] = speedDefense;
    data['speed'] = speed;
    return data;
  }
}
