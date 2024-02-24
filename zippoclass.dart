class post {
  String? postCode;
  String? country;
  String? countryAbbreviation;
  List<Places>? places;

  post({this.postCode, this.country, this.countryAbbreviation, this.places});

  post.fromJson(Map<String, dynamic> json) {
    postCode = json['post code'];
    country = json['country'];
    countryAbbreviation = json['country abbreviation'];
    if (json['places'] != null) {
      places = <Places>[];
      json['places'].forEach((v) {
        places!.add(new Places.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post code'] = this.postCode;
    data['country'] = this.country;
    data['country abbreviation'] = this.countryAbbreviation;
    if (this.places != null) {
      data['places'] = this.places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Places {
  String? placeName;
  String? longitude;
  String? state;
  String? stateAbbreviation;
  String? latitude;

  Places(
      {this.placeName,
        this.longitude,
        this.state,
        this.stateAbbreviation,
        this.latitude});

  Places.fromJson(Map<String, dynamic> json) {
    placeName = json['place name'];
    longitude = json['longitude'];
    state = json['state'];
    stateAbbreviation = json['state abbreviation'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place name'] = this.placeName;
    data['longitude'] = this.longitude;
    data['state'] = this.state;
    data['state abbreviation'] = this.stateAbbreviation;
    data['latitude'] = this.latitude;
    return data;
  }
}
