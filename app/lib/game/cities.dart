// ignore_for_file: constant_identifier_names

enum Cities {
  Edinburgh('Edinburgh'),
  Lisbon('Lisbon'),
  Madrid('Madrid'),
  Cadiz('Cadiz'),
  Barcelona('Barcelona'),
  Pamplona('Pamplona'),
  Paris('Paris'),
  Dieppe('Dieppe'),
  Brest('Brest'),
  London('London'),
  Amsterdam('Amsterdam'),
  Brussels('Brussels'),
  Zurich('Zurich'),
  Marseille('Marseille'),
  Palermo('Palermo'),
  Rome('Rome'),
  Venice('Venice'),
  Munich('Munich'),
  Frankfurt('Frankfurt'),
  Essen('Essen'),
  Berlin('Berlin'),
  Copenhagen('Copenhagen'),
  Stockholm('Stockholm'),
  Danzig('Danzig'),
  Vienna('Vienna'),
  Zagreb('Zagreb'),
  Sarajevo('Sarajevo'),
  Brindisi('Brindisi'),
  Athens('Athens'),
  Sofia('Sofia'),
  Smyrna('Smyrna'),
  Ankara('Ankara'),
  Constantinopole('Constantinopole'),
  Erzurm('Erzurm'),
  Sochi('Sochi'),
  Sevastopol('Sevastopol'),
  Bucharest('Bucharest'),
  Rostov('Rostov'),
  Kharkov('Kharkov'),
  Budapest('Budapest'),
  Kyiv('Kyiv'),
  Smolensk('Smolensk'),
  Vilnius('Vilnius'),
  Warsaw('Warsaw'),
  Riga('Riga'),
  Petrograd('Petrograd'),
  Moscow('Moscow');

  final String _name;
  const Cities(this._name);

  String get name {
    return _name;
  }
}
