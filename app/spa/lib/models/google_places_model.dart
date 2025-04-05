class GooglePlacesModel {
  String? description;
  List<MatchedSubstring>? matched_substrings;
  String? place_id;
  String? reference;
  StructuredFormatting? structured_formatting;
  List<Term>? terms;
  List<String>? types;

  GooglePlacesModel({this.description, this.matched_substrings, this.place_id, this.reference, this.structured_formatting, this.terms, this.types});

  factory GooglePlacesModel.fromJson(Map<String, dynamic> json) {
    return GooglePlacesModel(
      description: json['description'],
      matched_substrings: json['matched_substrings'] != null ? (json['matched_substrings'] as List).map((i) => MatchedSubstring.fromJson(i)).toList() : null,
      place_id: json['place_id'],
      reference: json['reference'],
      structured_formatting: json['structured_formatting'] != null ? StructuredFormatting.fromJson(json['structured_formatting']) : null,
      terms: json['terms'] != null ? (json['terms'] as List).map((i) => Term.fromJson(i)).toList() : null,
      types: json['types'] != null ? new List<String>.from(json['types']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['place_id'] = this.place_id;
    data['reference'] = this.reference;
    if (this.matched_substrings != null) {
      data['matched_substrings'] = this.matched_substrings!.map((v) => v.toJson()).toList();
    }
    if (this.structured_formatting != null) {
      data['structured_formatting'] = this.structured_formatting!.toJson();
    }
    if (this.terms != null) {
      data['terms'] = this.terms!.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types;
    }
    return data;
  }
}

class Term {
  int? offset;
  String? value;

  Term({this.offset, this.value});

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      offset: json['offset'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['value'] = this.value;
    return data;
  }
}

class MatchedSubstring {
  int? length;
  int? offset;

  MatchedSubstring({this.length, this.offset});

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) {
    return MatchedSubstring(
      length: json['length'],
      offset: json['offset'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['offset'] = this.offset;
    return data;
  }
}

class StructuredFormatting {
  String? main_text;
  List<MainTextMatchedSubstring>? main_text_matched_substrings;
  String? secondary_text;

  StructuredFormatting({this.main_text, this.main_text_matched_substrings, this.secondary_text});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      main_text: json['main_text'],
      main_text_matched_substrings: json['main_text_matched_substrings'] != null ? (json['main_text_matched_substrings'] as List).map((i) => MainTextMatchedSubstring.fromJson(i)).toList() : null,
      secondary_text: json['secondary_text'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main_text'] = this.main_text;
    data['secondary_text'] = this.secondary_text;
    if (this.main_text_matched_substrings != null) {
      data['main_text_matched_substrings'] = this.main_text_matched_substrings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainTextMatchedSubstring {
  int? length;
  int? offset;

  MainTextMatchedSubstring({this.length, this.offset});

  factory MainTextMatchedSubstring.fromJson(Map<String, dynamic> json) {
    return MainTextMatchedSubstring(
      length: json['length'],
      offset: json['offset'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['offset'] = this.offset;
    return data;
  }
}
