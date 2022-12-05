part of 'dashboard.dart';

class _Favorites extends StatelessWidget {
  const _Favorites();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const BrandTitle(text: 'My favorites'),
        isEmpty(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget isEmpty() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        gradient: BrandColors.blackGradient,
        border: Border.all(color: BrandColors.darkGreen),
        borderRadius: BorderRadius.circular(30),
      ),
      height: 174,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'History is empty',
            style: ThemeTypo.h2,
          ),
          const SizedBox(height: 10),
          Text(
            'Expolore new stations',
            style: ThemeTypo.regular.copyWith(
              color: const Color(0xFF9FA6B0),
            ),
          ),
        ],
      ),
    );
  }
}
