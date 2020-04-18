class Timeline {
  String UpdateDate;
  String Source;
  String DevBy;
  String SeverBy;
  List<_Data> Data;
  List<Chart> ChartData;
  List<Chart> ChartData2;

  Timeline.fromJsonMap(Map<String, dynamic> map)
      : UpdateDate = map["UpdateDate"],
        Source = map["Source"],
        DevBy = map["DevBy"],
        SeverBy = map["SeverBy"],
        Data = List<_Data>.from(map["Data"].map((it) => _Data.fromJsonMap(it))),
        ChartData2 =
            List<Chart>.from(map["Data"].map((it) => Chart.fromJsonMap(it))),
        ChartData =
            List<Chart>.from(map["Data"].map((it) => Chart.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UpdateDate'] = UpdateDate;
    data['Source'] = Source;
    data['DevBy'] = DevBy;
    data['SeverBy'] = SeverBy;
    data['Data'] =
        Data != null ? this.Data.map((v) => v.toJson()).toList() : null;
    return data;
  }
}

class _Data {
  String Date;
  int NewConfirmed;
  int NewRecovered;
  int NewHospitalized;
  int NewDeaths;
  int Confirmed;
  int Recovered;
  int Hospitalized;
  int Deaths;

  _Data.fromJsonMap(Map<String, dynamic> map)
      : Date = map["Date"],
        NewConfirmed = map["NewConfirmed"],
        NewRecovered = map["NewRecovered"],
        NewHospitalized = map["NewHospitalized"],
        NewDeaths = map["NewDeaths"],
        Confirmed = map["Confirmed"],
        Recovered = map["Recovered"],
        Hospitalized = map["Hospitalized"],
        Deaths = map["Deaths"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = Date;
    data['NewConfirmed'] = NewConfirmed;
    data['NewRecovered'] = NewRecovered;
    data['NewHospitalized'] = NewHospitalized;
    data['NewDeaths'] = NewDeaths;
    data['Confirmed'] = Confirmed;
    data['Recovered'] = Recovered;
    data['Hospitalized'] = Hospitalized;
    data['Deaths'] = Deaths;
    return data;
  }
}

class Chart {
  String name;
  int value;

  Chart.fromJsonMap(Map<String, dynamic> map)
      : name = map['Date'],
        value = map["Confirmed"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class Chart2 {
  String name;
  int value;

  Chart2.fromJsonMap(Map<String, dynamic> map)
      : name = map['Date'],
        value = map["NewConfirmed"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
