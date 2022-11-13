import 'cities.dart';

// ignore_for_file: constant_identifier_names

enum Tickets {
  Brussels_Danzig({Cities.Brussels, Cities.Danzig}, 9),
  Frankfurt_Copenhagen({Cities.Frankfurt, Cities.Copenhagen}, 5),
  Brest_Venice({Cities.Brest, Cities.Venice}, 8),
  Zagreb_Brindisi({Cities.Zagreb, Cities.Brindisi}, 6),
  Brest_Marseille({Cities.Brest, Cities.Marseille}, 7),
  Sofia_Smyrna({Cities.Sofia, Cities.Smyrna}, 5),
  Barcelona_Munich({Cities.Barcelona, Cities.Munich}, 8),
  Madrid_Zurich({Cities.Madrid, Cities.Zurich}, 8),
  Budapest_Sofia({Cities.Budapest, Cities.Sofia}, 5),
  Athens_Ankara({Cities.Athens, Cities.Ankara}, 5),
  London_Vienna({Cities.London, Cities.Vienna}, 10),
  Sarajevo_Sevastopol({Cities.Sarajevo, Cities.Sevastopol}, 8),
  Ankara_Kharkov({Cities.Ankara, Cities.Kharkov}, 10),
  Smolensk_Rostov({Cities.Smolensk, Cities.Rostov}, 8),
  Rostov_Erzurm({Cities.Rostov, Cities.Erzurm}, 5),
  Paris_Vienna({Cities.Paris, Cities.Vienna}, 8),
  Venice_Constantinopole({Cities.Venice, Cities.Constantinopole}, 10),
  Edinburgh_Paris({Cities.Edinburgh, Cities.Paris}, 7),
  Athens_Vilnius({Cities.Athens, Cities.Vilnius}, 11),
  Berlin_Moscow({Cities.Berlin, Cities.Moscow}, 12),
  Barcelona_Brussels({Cities.Barcelona, Cities.Brussels}, 8),
  Amsterdam_Vilnius({Cities.Amsterdam, Cities.Vilnius}, 12),
  Paris_Zagreb({Cities.Paris, Cities.Zagreb}, 7),
  Frankfurt_Smolensk({Cities.Frankfurt, Cities.Smolensk}, 13),
  Kyiv_Petrograd({Cities.Kyiv, Cities.Petrograd}, 6),
  Marseille_Essen({Cities.Marseille, Cities.Essen}, 8),
  Zurich_Brindisi({Cities.Zurich, Cities.Brindisi}, 6),
  Berlin_Rome({Cities.Berlin, Cities.Rome}, 9),
  Stockholm_Vienna({Cities.Stockholm, Cities.Vienna}, 11),
  London_Berlin({Cities.London, Cities.Berlin}, 7),
  Zurich_Budapest({Cities.Zurich, Cities.Budapest}, 6),
  Warsaw_Smolensk({Cities.Warsaw, Cities.Smolensk}, 6),
  Rome_Smyrna({Cities.Rome, Cities.Smyrna}, 8),
  Madrid_Dieppe({Cities.Madrid, Cities.Dieppe}, 8),
  Riga_Bucharest({Cities.Riga, Cities.Bucharest}, 10),
  Palermo_Constantinopole({Cities.Palermo, Cities.Constantinopole}, 8),
  Essen_Kyiv({Cities.Essen, Cities.Kyiv}, 10),
  Kyiv_Sochi({Cities.Kyiv, Cities.Sochi}, 8),
  Amsterdam_Pamplona({Cities.Amsterdam, Cities.Pamplona}, 7),
  Berlin({Cities.Berlin, Cities.Bucharest}, 8),
  Cadiz_Stockholm({Cities.Cadiz, Cities.Stockholm}, 21),
  Brest_Petrograd({Cities.Brest, Cities.Petrograd}, 20),
  Edinburgh_Athens({Cities.Edinburgh, Cities.Athens}, 21),
  Copenhagen_Erzurm({Cities.Copenhagen, Cities.Erzurm}, 21),
  Lisbon_Danzig({Cities.Lisbon, Cities.Danzig}, 20),
  Palermo_Moscow({Cities.Palermo, Cities.Moscow}, 20);

  final Set<Cities> _cities;
  final int _points;
  const Tickets(this._cities, this._points);

  Set<Cities> get cities {
    return _cities;
  }

  int get points {
    return _points;
  }
}
