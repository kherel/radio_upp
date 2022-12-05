part of 'dashboard.dart';

class _Local extends StatelessWidget {
  const _Local();

  @override
  Widget build(BuildContext context) {
    var localStations = context.watch<LocalStationsCubit>().state;

    var children = <Widget>[
      const BrandTitle(text: 'Local station'),
      const SizedBox(height: 24),
    ];
    if (localStations is! LocalStationsLoaded) {
      children.add(const Expanded(
        child: Text('loading'),
      ));
    } else {
      children.add(SizedBox(
        height: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: index == 0 ? 30 : 0),
              child: _LocalStationCard(
                key: ValueKey(localStations.stations[index].id),
                station: localStations.stations[index],
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(
            width: 10,
          ),
          itemCount: localStations.stations.length,
        ),
      ));
    }
    children.add(
      const SizedBox(height: 30),
    );
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(30)),
        gradient: LinearGradient(
          begin: const Alignment(-1.0, 1),
          end: const Alignment(1.0, 0.0),
          colors: [
            BrandColors.blue.withOpacity(0),
            BrandColors.blue,
          ],
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _LocalStationCard extends StatelessWidget {
  const _LocalStationCard({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: BrandColors.darkBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://www.radioair.info/images_radios/${station.logoUrl}',
                  placeholder: (context, url) => const BrandLoader(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      station.name,
                      style: ThemeTypo.basis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    GenreLabel(genre: station.genre),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
