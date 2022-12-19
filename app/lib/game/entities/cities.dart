// ignore_for_file: constant_identifier_names

enum Cities {
  Edinburgh('Edinburgh', [499, 1819]),
  Lisbon('Lisbon', [138, 273]),
  Madrid('Madrid', [331, 338]),
  Cadiz('Cadiz', [325, 125]),
  Barcelona('Barcelona', [649, 310]),
  Pamplona('Pamplona', [617, 574]),
  Paris('Paris', [799, 1008]),
  Dieppe('Dieppe', [660, 1134]),
  Brest('Brest', [403, 1051]),
  London('London', [691, 1391]),
  Amsterdam('Amsterdam', [964, 1379]),
  Brussels('Brussels', [901, 1246]),
  Zurich('Zurich', [1125, 852]),
  Marseille('Marseille', [1048, 586]),
  Palermo('Palermo', [1489, 132]),
  Rome('Rome', [1383, 505]),
  Venice('Venice', [1361, 759]),
  Munich('Munich', [1314, 1032]),
  Frankfurt('Frankfurt', [1150, 1155]),
  Essen('Essen', [1194, 1355]),
  Berlin('Berlin', [1474, 1313]),
  Copenhagen('Copenhagen', [1397, 1654]),
  Stockholm('Stockholm', [1688, 1873]),
  Danzig('Danzig', [1799, 1534]),
  Vienna('Vienna', [1636, 983]),
  Zagreb('Zagreb', [1600, 724]),
  Sarajevo('Sarajevo', [1840, 560]),
  Brindisi('Brindisi', [1627, 432]),
  Athens('Athens', [1978, 212]),
  Sofia('Sofia', [2029, 536]),
  Smyrna('Smyrna', [2221, 137]),
  Ankara('Ankara', [2569, 205]),
  Constantinopole('Constantinopole', [2345, 363]),
  Erzurm('Erzurm', [2802, 272]),
  Sochi('Sochi', [2855, 631]),
  Sevastopol('Sevastopol', [2595, 675]),
  Bucharest('Bucharest', [2203, 716]),
  Rostov('Rostov', [2867, 888]),
  Kharkov('Kharkov', [2751, 1039]),
  Budapest('Budapest', [1773, 913]),
  Kyiv('Kyiv', [2365, 1187]),
  Smolensk('Smolensk', [2546, 1398]),
  Vilnius('Vilnius', [2254, 1408]),
  Warsaw('Warsaw', [1934, 1337]),
  Riga('Riga', [2032, 1792]),
  Petrograd('Petrograd', [2514, 1810]),
  Moscow('Moscow', [2793, 1468]);

  final String _name;
  final List<int> _location;
  const Cities(this._name, this._location);

  String get name => _name;

  List<int> get location => _location;
}
