/// Confirmed : 2643
/// Recovered : 1497
/// Hospitalized : 1103
/// Deaths : 43
/// NewConfirmed : 30
/// NewRecovered : 92
/// NewHospitalized : -64
/// NewDeaths : 2
/// UpdateDate : "15/04/2020 11:36"
/// Source : "https://covid19.th-stat.com/"
/// DevBy : "https://www.kidkarnmai.com/"
/// SeverBy : "https://smilehost.asia/"

class Stat {
  int _Confirmed;
  int _Recovered;
  int _Hospitalized;
  int _Deaths;
  int _NewConfirmed;
  int _NewRecovered;
  int _NewHospitalized;
  int _NewDeaths;
  String _UpdateDate;
  String _Source;
  String _DevBy;
  String _SeverBy;

  int get Confirmed => _Confirmed;
  int get Recovered => _Recovered;
  int get Hospitalized => _Hospitalized;
  int get Deaths => _Deaths;
  int get NewConfirmed => _NewConfirmed;
  int get NewRecovered => _NewRecovered;
  int get NewHospitalized => _NewHospitalized;
  int get NewDeaths => _NewDeaths;
  String get UpdateDate => _UpdateDate;
  String get Source => _Source;
  String get DevBy => _DevBy;
  String get SeverBy => _SeverBy;

  Stat(this._Confirmed, this._Recovered, this._Hospitalized, this._Deaths, this._NewConfirmed, this._NewRecovered, this._NewHospitalized, this._NewDeaths, this._UpdateDate, this._Source, this._DevBy, this._SeverBy);

  Stat.map(dynamic obj) {
    this._Confirmed = obj["Confirmed"];
    this._Recovered = obj["Recovered"];
    this._Hospitalized = obj["Hospitalized"];
    this._Deaths = obj["Deaths"];
    this._NewConfirmed = obj["NewConfirmed"];
    this._NewRecovered = obj["NewRecovered"];
    this._NewHospitalized = obj["NewHospitalized"];
    this._NewDeaths = obj["NewDeaths"];
    this._UpdateDate = obj["UpdateDate"];
    this._Source = obj["Source"];
    this._DevBy = obj["DevBy"];
    this._SeverBy = obj["SeverBy"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["Confirmed"] = _Confirmed;
    map["Recovered"] = _Recovered;
    map["Hospitalized"] = _Hospitalized;
    map["Deaths"] = _Deaths;
    map["NewConfirmed"] = _NewConfirmed;
    map["NewRecovered"] = _NewRecovered;
    map["NewHospitalized"] = _NewHospitalized;
    map["NewDeaths"] = _NewDeaths;
    map["UpdateDate"] = _UpdateDate;
    map["Source"] = _Source;
    map["DevBy"] = _DevBy;
    map["SeverBy"] = _SeverBy;
    return map;
  }

}