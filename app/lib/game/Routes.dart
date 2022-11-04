import 'Cities.dart';

enum Routes {
  Cadiz_Lisbon({Cities.Cadiz, Cities.Lisbon}, 2),
  Cadiz_Madrid({Cities.Cadiz, Cities.Madrid}, 3),
  Madrid_Barcelona({Cities.Madrid, Cities.Barcelona}, 2),
  Lisbon_Madrid({Cities.Lisbon, Cities.Madrid}, 3),
  Madrid_Pamplona({Cities.Madrid, Cities.Pamplona}, 3),
  Pamplona_Barcelona({Cities.Pamplona, Cities.Barcelona}, 2),
  Barcelona_Marseille({Cities.Barcelona, Cities.Marseille}, 4),
  Pamplona_Marseille({Cities.Pamplona, Cities.Marseille}, 4),
  Pamplona_Paris({Cities.Pamplona, Cities.Paris}, 4),
  Pamplona_Brest({Cities.Pamplona, Cities.Brest}, 4),
  Brest_Paris({Cities.Brest, Cities.Paris}, 3),
  Brest_Dieppe({Cities.Brest, Cities.Dieppe}, 2),
  Dieppe_London({Cities.Dieppe, Cities.London}, 2),
  London_Edinburgh({Cities.London, Cities.Edinburgh}, 4),
  London_Amsterdam({Cities.London, Cities.Amsterdam}, 2),
  Dieppe_Brussels({Cities.Dieppe, Cities.Brussels}, 2),
  Paris_Brussels({Cities.Paris, Cities.Brussels}, 2),
  Brussels_Amsterdam({Cities.Brussels, Cities.Amsterdam}, 1),
  Brussels_Frankfurt({Cities.Brussels, Cities.Frankfurt}, 2),
  Amsterdam_Frankfurt({Cities.Amsterdam, Cities.Frankfurt}, 2),
  Amsterdam_Essen({Cities.Amsterdam, Cities.Essen}, 3),
  Paris_Frankfurt({Cities.Paris, Cities.Frankfurt}, 3),
  Paris_Zurich({Cities.Paris, Cities.Zurich}, 3),
  Paris_Marseille({Cities.Paris, Cities.Marseille}, 4),
  Marseille_Rome({Cities.Marseille, Cities.Rome}, 4),
  Marseille_Zurich({Cities.Marseille, Cities.Zurich}, 2),
  Zurich_Venice({Cities.Zurich, Cities.Venice}, 2),
  Zurich_Munich({Cities.Zurich, Cities.Munich}, 2),
  Munich_Frankfurt({Cities.Munich, Cities.Frankfurt}, 2),
  Frankfurt_Berlin({Cities.Frankfurt, Cities.Berlin}, 3),
  Frankfurt_Essen({Cities.Frankfurt, Cities.Essen}, 2),
  Essen_Berlin({Cities.Essen, Cities.Berlin}, 2),
  Essen_Copenhagen({Cities.Essen, Cities.Copenhagen}, 3),
  Copenhagen_Stockholm({Cities.Copenhagen, Cities.Stockholm}, 3),
  Stockholm_Petrograd({Cities.Stockholm, Cities.Petrograd}, 8),
  Riga_Petrograd({Cities.Riga, Cities.Petrograd}, 4),
  Berlin_Danzig({Cities.Berlin, Cities.Danzig}, 4),
  Danzig_Riga({Cities.Danzig, Cities.Riga}, 3),
  Riga_Vilnius({Cities.Riga, Cities.Vilnius}, 4),
  Petrograd_Moscow({Cities.Petrograd, Cities.Moscow}, 4),
  Vilnius_Petrograd({Cities.Vilnius, Cities.Petrograd}, 4),
  Smolensk_Moscow({Cities.Smolensk, Cities.Moscow}, 2),
  Moscow_Kharkov({Cities.Moscow, Cities.Kharkov}, 4),
  Smolensk_Kyiv({Cities.Smolensk, Cities.Kyiv}, 3),
  Vilnius_Smolensk({Cities.Vilnius, Cities.Smolensk}, 3),
  Warsaw_Vilnius({Cities.Warsaw, Cities.Vilnius}, 3),
  Danzig_Warsaw({Cities.Danzig, Cities.Warsaw}, 2),
  Berlin_Warsaw({Cities.Berlin, Cities.Warsaw}, 4),
  Warsaw_Kyiv({Cities.Warsaw, Cities.Kyiv}, 4),
  Budapest_Kyiv({Cities.Budapest, Cities.Kyiv}, 6),
  Vienna_Warsaw({Cities.Vienna, Cities.Warsaw}, 4),
  Berlin_Vienna({Cities.Berlin, Cities.Vienna}, 3),
  Munich_Vienna({Cities.Munich, Cities.Vienna}, 3),
  Venice_Zagreb({Cities.Venice, Cities.Zagreb}, 2),
  Venice_Rome({Cities.Venice, Cities.Rome}, 2),
  Rome_Brindisi({Cities.Rome, Cities.Brindisi}, 2),
  Rome_Palermo({Cities.Rome, Cities.Palermo}, 4),
  Palermo_Brindisi({Cities.Palermo, Cities.Brindisi}, 3),
  Brindisi_Athens({Cities.Brindisi, Cities.Athens}, 4),
  Sarajevo_Athens({Cities.Sarajevo, Cities.Athens}, 4),
  Palermo_Smyrna({Cities.Palermo, Cities.Smyrna}, 6),
  Athens_Smyrna({Cities.Athens, Cities.Smyrna}, 2),
  Sofia_Athens({Cities.Sofia, Cities.Athens}, 3),
  Smyrna_Ankara({Cities.Smyrna, Cities.Ankara}, 3),
  Smyrna_Constantinople({Cities.Smyrna, Cities.Constantinople}, 2),
  Sofia_Constantinople({Cities.Sofia, Cities.Constantinople}, 3),
  Sarajevo_Sofia({Cities.Sarajevo, Cities.Sofia}, 2),
  Zagreb_Sarajevo({Cities.Zagreb, Cities.Sarajevo}, 3),
  Vienna_Zagreb({Cities.Vienna, Cities.Zagreb}, 2),
  Vienna_Budapest({Cities.Vienna, Cities.Budapest}, 1),
  Zagreb_Budapest({Cities.Zagreb, Cities.Budapest}, 2),
  Budapest_Sarajevo({Cities.Budapest, Cities.Sarajevo}, 3),
  Budapest_Bucharest({Cities.Budapest, Cities.Bucharest}, 4),
  Sofia_Bucharest({Cities.Sofia, Cities.Bucharest}, 2),
  Bucharest_Constantinople({Cities.Bucharest, Cities.Constantinople}, 3),
  Constantinople_Sevastopol({Cities.Constantinople, Cities.Sevastopol}, 4),
  Constantinople_Ankara({Cities.Constantinople, Cities.Ankara}, 2),
  Ankara_Erzurm({Cities.Ankara, Cities.Erzurm}, 3),
  Sevastopol_Erzurm({Cities.Sevastopol, Cities.Erzurm}, 4),
  Sochi_Erzurm({Cities.Sochi, Cities.Erzurm}, 3),
  Sevastopol_Sochi({Cities.Sevastopol, Cities.Sochi}, 2),
  Bucharest_Sevastopol({Cities.Bucharest, Cities.Sevastopol}, 4),
  Kyiv_Bucharest({Cities.Kyiv, Cities.Bucharest}, 4),
  Kyiv_Kharkov({Cities.Kyiv, Cities.Kharkov}, 4),
  Kharkov_Rostov({Cities.Kharkov, Cities.Rostov}, 2),
  Rostov_Sevastopol({Cities.Rostov, Cities.Sevastopol}, 4),
  Rostov_Sochi({Cities.Rostov, Cities.Sochi}, 3);

  final Set<Cities> cities;
  final int distance;

  const Routes(this.cities, this.distance);

  Set<Cities> getCities() {
    return this.cities;
  }

  List<String> getCitiesNames() {
    List<String> names = [];
    for (Cities city in this.getCities()) {
      names.add(city.getName());
    }
    return names;
  }

  String toShortString() {
    return "From " + this.getCitiesNames().join(' to ');
  }

  int getDistance() {
    return this.distance;
  }

  int getPoints() {
    switch (this.distance) {
      case 1:
        return 1;
      case 2:
        return 2;
      case 3:
        return 4;
      case 4:
        return 7;
      case 6:
        return 15;
      case 8:
        return 21;
    }
    return -1;
  }
}
