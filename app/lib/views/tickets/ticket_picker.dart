import 'package:app/game/entities/cities.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TicketPicker extends HookWidget {
  const TicketPicker({
    required this.availableTickets,
    Key? key,
  }) : super(key: key);

  final List<Tickets> availableTickets;
  @override
  Widget build(BuildContext context) {
    final possibleCities = useState(
      () {
        final tmp = availableTickets
            .map((e) => e.cities)
            .expand((e) => e)
            .toSet()
            .toList();
        tmp.sort((a, b) => a.name.compareTo(b.name));
        return tmp;
      }(),
    );
    final firstCity = useState<Cities?>(null);
    final isFirstCity = firstCity.value == null;
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      color: C.white,
      child: SizedBox(
        height: 720,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Text(
                isFirstCity
                    ? "Wybierz pierwsze miasto"
                    : "Wybierz drugie miasto",
                style: TS.larger.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  padding: const EdgeInsets.all(16),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: possibleCities.value
                      .map(
                        (city) => _CityCard(
                          city: city,
                          onTap: () {
                            if (isFirstCity) {
                              final localPossibleCities = availableTickets
                                  .where((t) => t.cities.contains(city))
                                  .map((t) => t.cities)
                                  .expand((c) => c)
                                  .where((c) => c != city)
                                  .toSet()
                                  .toList();
                              localPossibleCities
                                  .sort((a, b) => a.name.compareTo(b.name));
                              possibleCities.value = localPossibleCities;
                              firstCity.value = city;
                            } else {
                              final ticket = availableTickets
                                  .where(
                                    (t) => t.cities.contains(firstCity.value),
                                  )
                                  .where((t) => t.cities.contains(city))
                                  .first;
                              Navigator.pop(context, ticket);
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CityCard extends StatelessWidget {
  const _CityCard({
    Key? key,
    required this.city,
    required this.onTap,
  }) : super(key: key);

  final Cities city;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 16,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
        color: C.light,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              const Positioned(
                left: 8,
                top: 8,
                child: Icon(
                  Icons.confirmation_num_outlined,
                  size: 16,
                  color: C.lightestest,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      city.name,
                      textAlign: TextAlign.center,
                      style: TS.small.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
