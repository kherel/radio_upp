part of 'dashboard.dart';

class _GenresBlock extends StatefulWidget {
  const _GenresBlock();

  @override
  State<_GenresBlock> createState() => __GenresBlockState();
}

final half = (Genre.values.length / 2).floor();
final firstList = Genre.values.take(half).toList();
final secondList = Genre.values.skip(half).toList();

class __GenresBlockState extends State<_GenresBlock> {
  final topListController = InfiniteScrollController();
  final bottomListController =
      InfiniteScrollController(initialScrollOffset: 70);
  var scrollingList = ScrollingList.none;

  @override
  void dispose() {
    topListController.dispose();
    bottomListController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<SearchCubit>();
    Station? playingStation;
    var radioState = context.watch<RadioCubit>().state;
    if (radioState is RadioCubitStateWithStation) {
      playingStation = radioState.station;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BrandTitle(text: 'Genre'),
        const SizedBox(height: 14),
        SizedBox(
          height: 80,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                if (scrollingList == ScrollingList.none) {
                  scrollingList = ScrollingList.top;
                }
              } else if (notification is ScrollEndNotification) {
                if (scrollingList == ScrollingList.top) {
                  scrollingList = ScrollingList.none;
                }
              }
              if (scrollingList == ScrollingList.top) {
                bottomListController.jumpTo(topListController.offset + 70);
              }
              return true;
            },
            child: getListView(
                topListController, firstList, cubit, playingStation),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 80,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                if (scrollingList == ScrollingList.none) {
                  scrollingList = ScrollingList.bottom;
                }
              } else if (notification is ScrollEndNotification) {
                if (scrollingList == ScrollingList.bottom) {
                  scrollingList = ScrollingList.none;
                }
              }
              if (scrollingList == ScrollingList.bottom) {
                topListController.jumpTo(bottomListController.offset - 70);
              }
              return true;
            },
            child: getListView(
                bottomListController, secondList, cubit, playingStation),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget getListView(
    InfiniteScrollController controller,
    List<Genre> list,
    SearchCubit cubit,
    Station? playingStation,
  ) {
    var state = cubit.state;
    Genre? loadingGenre;
    if (state is StationsLoading) {
      loadingGenre = state.genre;
    }
    return InfiniteListView.separated(
      controller: controller,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (_, index) {
        var genre = list[index == 0 ? 0 : index % list.length];
        return _GenreCard(
          key: ValueKey(genre.id),
          genre: genre,
          isLoading: loadingGenre == genre,
          isPlaying: playingStation?.genre == genre,
        );
      },
    );
  }
}

enum ScrollingList {
  none,
  top,
  bottom,
}

class _GenreCard extends StatelessWidget {
  const _GenreCard({
    Key? key,
    required this.genre,
    required this.isLoading,
    required this.isPlaying,
  }) : super(key: key);

  final Genre genre;
  final bool isLoading;

  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<SearchCubit>().search(genre: genre),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white30,
          border: isPlaying ? Border.all(color: BrandColors.darkGreen) : null,
          image: DecorationImage(
            colorFilter: const ColorFilter.mode(
              Colors.black12,
              BlendMode.darken,
            ),
            image: AssetImage(
              'assets/images/genres/${genre.fileName}.webp',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        BrandColors.secondaryBlack,
                        BrandColors.secondaryBlack.withOpacity(0)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0.5, 0.5),
                      end: const Alignment(1.8, -1.8),
                      colors: [
                        BrandColors.darkGreen.withOpacity(0),
                        BrandColors.darkGreen.withOpacity(0.4)
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: const Alignment(0, 0.8),
                child: Text(
                  genre.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: ThemeTypo.small,
                  maxLines: 2,
                ),
              ),
              if (isLoading)
                const Align(
                  alignment: Alignment.center,
                  child: BrandLoader(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
