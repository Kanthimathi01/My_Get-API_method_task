class heyy {
  List<Data>? data;
  List<Source>? source;

  heyy({this.data, this.source});

  heyy.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['source'] != null) {
      source = <Source>[];
      json['source'].forEach((v) {
        source!.add(new Source.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.source != null) {
      data['source'] = this.source!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? iDNation;
  String? nation;
  int? iDYear;
  String? year;
  int? population;
  String? slugNation;

  Data(
      {this.iDNation,
        this.nation,
        this.iDYear,
        this.year,
        this.population,
        this.slugNation});

  Data.fromJson(Map<String, dynamic> json) {
    iDNation = json['ID Nation'];
    nation = json['Nation'];
    iDYear = json['ID Year'];
    year = json['Year'];
    population = json['Population'];
    slugNation = json['Slug Nation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID Nation'] = this.iDNation;
    data['Nation'] = this.nation;
    data['ID Year'] = this.iDYear;
    data['Year'] = this.year;
    data['Population'] = this.population;
    data['Slug Nation'] = this.slugNation;
    return data;
  }
}

class Source {
  List<String>? measures;
  Annotations? annotations;
  String? name;
  // List<Null>? substitutions;

  Source({this.measures, this.annotations, this.name,});

  Source.fromJson(Map<String, dynamic> json) {
    measures = json['measures'].cast<String>();
    annotations = json['annotations'] != null
        ? new Annotations.fromJson(json['annotations'])
        : null;
    name = json['name'];
    //   if (json['substitutions'] != null) {
    //     substitutions = <Null>[];
    //     json['substitutions'].forEach((v) {
    //       substitutions!.add(new Null.fromJson(v));
    //     });
    //   }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['measures'] = this.measures;
    if (this.annotations != null) {
      data['annotations'] = this.annotations!.toJson();
    }
    data['name'] = this.name;
    // if (this.substitutions != null) {
    //   data['substitutions'] =
    //       this.substitutions!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Annotations {
  String? sourceName;
  String? sourceDescription;
  String? datasetName;
  String? datasetLink;
  String? tableId;
  String? topic;
  String? subtopic;

  Annotations(
      {this.sourceName,
        this.sourceDescription,
        this.datasetName,
        this.datasetLink,
        this.tableId,
        this.topic,
        this.subtopic});

  Annotations.fromJson(Map<String, dynamic> json) {
    sourceName = json['source_name'];
    sourceDescription = json['source_description'];
    datasetName = json['dataset_name'];
    datasetLink = json['dataset_link'];
    tableId = json['table_id'];
    topic = json['topic'];
    subtopic = json['subtopic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source_name'] = this.sourceName;
    data['source_description'] = this.sourceDescription;
    data['dataset_name'] = this.datasetName;
    data['dataset_link'] = this.datasetLink;
    data['table_id'] = this.tableId;
    data['topic'] = this.topic;
    data['subtopic'] = this.subtopic;
    return data;
  }
}
