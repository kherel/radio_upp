import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:radio_upp/config/brand_colors.dart';

class Logo extends StatefulWidget {
  const Logo.small({super.key})
      : size = const Size(158, 22),
        hasRandomPeriodicTimer = true;

  const Logo.big({super.key})
      : size = const Size(214, 30),
        hasRandomPeriodicTimer = false;

  final Size size;
  final bool hasRandomPeriodicTimer;

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<Color?> strokeColor;
  late Animation<Color?> bluredStokeColor;
  late Animation<double?> bluredStokeOpacity;

  Timer? timer;
  final random = Random();

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    controller.dispose();
  }

  void _initTimer() {
    timer = Timer(genRandomDuration(), _initTimer);
    controller.forward(from: 0);
  }

  Duration genRandomDuration() => Duration(seconds: 5 + random.nextInt(10));

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    strokeColor = TweenSequence<Color?>([
      TweenSequenceItem<Color?>(
        tween: ColorTween(
          begin: BrandColors.darkGreen,
          end: BrandColors.lightGreen,
        ),
        weight: 10,
      ),
      TweenSequenceItem<Color?>(
        tween: ColorTween(
          begin: BrandColors.lightGreen,
          end: BrandColors.darkGreen,
        ),
        weight: 4,
      ),
      TweenSequenceItem<Color?>(
        tween: ColorTween(
          begin: BrandColors.darkGreen,
          end: BrandColors.secondaryBlack,
        ),
        weight: 1,
      ),
      TweenSequenceItem<Color?>(
        tween: ColorTween(
          begin: BrandColors.secondaryBlack,
          end: BrandColors.darkGreen,
        ),
        weight: 1,
      ),
    ]).animate(controller);

    bluredStokeColor = TweenSequence<Color?>([
      TweenSequenceItem<Color?>(
        tween: ColorTween(
          begin: BrandColors.darkGreen,
          end: BrandColors.middleGreen,
        ),
        weight: 10,
      ),
      TweenSequenceItem<Color?>(
        tween: ColorTween(
          begin: BrandColors.middleGreen,
          end: BrandColors.darkGreen,
        ),
        weight: 4,
      ),
      TweenSequenceItem<Color?>(
        tween: ColorTween(
          begin: BrandColors.darkGreen,
          end: BrandColors.secondaryBlack,
        ),
        weight: 1,
      ),
      TweenSequenceItem<Color?>(
        tween: ColorTween(
          begin: BrandColors.secondaryBlack,
          end: BrandColors.darkGreen,
        ),
        weight: 1,
      ),
    ]).animate(controller);

    bluredStokeOpacity = TweenSequence<double?>([
      TweenSequenceItem<double?>(
        tween: Tween<double>(
          begin: 0.8,
          end: 1,
        ),
        weight: 4,
      ),
      TweenSequenceItem<double?>(
        tween: Tween<double>(
          begin: 1,
          end: 0.6,
        ),
        weight: 3,
      ),
      TweenSequenceItem<double?>(
        tween: Tween<double>(
          begin: 0.6,
          end: 0,
        ),
        weight: 1,
      ),
      TweenSequenceItem<double?>(
        tween: Tween<double>(
          begin: 0,
          end: 0.8,
        ),
        weight: 1,
      ),
    ]).animate(controller);

    if (widget.hasRandomPeriodicTimer) {
      timer = Timer(genRandomDuration(), _initTimer);
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          var bluredColorOpacity = bluredStokeOpacity.value ?? 0.8;
          return CustomPaint(
            size: const Size(158, 22),
            painter: LogoPainter(
              strokeColor: strokeColor.value ?? BrandColors.darkGreen,
              bluredStokeColor: bluredStokeColor.value ?? BrandColors.darkGreen,
              bluredStokeOpacity: bluredColorOpacity,
              shadowbluredStokeOpacity: Tween<double>(
                begin: 0.8,
                end: 1,
              ).transform(bluredColorOpacity),
            ),
          );
        });
  }
}

class LogoPainter extends CustomPainter {
  const LogoPainter({
    required this.strokeColor,
    required this.bluredStokeColor,
    required this.bluredStokeOpacity,
    required this.shadowbluredStokeOpacity,
  });

  final Color strokeColor;
  final Color bluredStokeColor;
  final double bluredStokeOpacity;
  final double shadowbluredStokeOpacity;
  @override
  void paint(Canvas canvas, Size size) {
    var pathOne = getPathOne(size);

    canvas.drawPath(
      pathOne,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white.withOpacity(1.0),
    );

    var paths = <Path>[
      paintFlash(size),
      paintSecondPart(size),
    ];

    drawNeon(canvas, paths);
  }

  void drawNeon(Canvas canvas, List<Path> paths) {
    var strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = strokeColor;

    var wallLight1 = bluredStokeColor.withOpacity(bluredStokeOpacity);
    var wallLight2 = bluredStokeColor.withOpacity(shadowbluredStokeOpacity);

    var bluredPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = wallLight1
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);
    for (var path in paths) {
      canvas.drawPath(path, strokePaint);
      canvas.drawPath(path, bluredPaint);
      canvas.save();
      canvas.translate(0, -13);
      canvas.drawShadow(path, wallLight2, 10, false);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path getPathOne(Size size) {
    return Path()
      ..moveTo(size.width * 0.5735203, size.height * 0.8867909)
      ..cubicTo(
          size.width * 0.6112513,
          size.height * 0.8867909,
          size.width * 0.6347405,
          size.height * 0.7257318,
          size.width * 0.6347405,
          size.height * 0.4950227)
      ..cubicTo(
          size.width * 0.6347405,
          size.height * 0.2632250,
          size.width * 0.6110994,
          size.height * 0.09889909,
          size.width * 0.5735203,
          size.height * 0.09889909)
      ..cubicTo(
          size.width * 0.5360930,
          size.height * 0.09889909,
          size.width * 0.5121513,
          size.height * 0.2632250,
          size.width * 0.5121513,
          size.height * 0.4950227)
      ..cubicTo(
          size.width * 0.5121513,
          size.height * 0.7268182,
          size.width * 0.5360930,
          size.height * 0.8867909,
          size.width * 0.5735203,
          size.height * 0.8867909)
      ..close()
      ..moveTo(size.width * 0.5733690, size.height * 0.7126727)
      ..cubicTo(
          size.width * 0.5530639,
          size.height * 0.7126727,
          size.width * 0.5409418,
          size.height * 0.6212591,
          size.width * 0.5409418,
          size.height * 0.4950227)
      ..cubicTo(
          size.width * 0.5409418,
          size.height * 0.3687855,
          size.width * 0.5533671,
          size.height * 0.2730191,
          size.width * 0.5733690,
          size.height * 0.2730191)
      ..cubicTo(
          size.width * 0.5938253,
          size.height * 0.2730191,
          size.width * 0.6059475,
          size.height * 0.3687855,
          size.width * 0.6059475,
          size.height * 0.4950227)
      ..cubicTo(
          size.width * 0.6059475,
          size.height * 0.6212591,
          size.width * 0.5939766,
          size.height * 0.7126727,
          size.width * 0.5733690,
          size.height * 0.7126727)
      ..close()
      ..moveTo(size.width * 0.1078886, size.height * 0.8084227)
      ..lineTo(size.width * 0.1024335, size.height * 0.6800091)
      ..cubicTo(
          size.width * 0.09985759,
          size.height * 0.6201545,
          size.width * 0.09394747,
          size.height * 0.5809773,
          size.width * 0.08667405,
          size.height * 0.5613864)
      ..cubicTo(
          size.width * 0.1016759,
          size.height * 0.5320045,
          size.width * 0.1107671,
          size.height * 0.4601818,
          size.width * 0.1107671,
          size.height * 0.3611505)
      ..cubicTo(
          size.width * 0.1107671,
          size.height * 0.2131482,
          size.width * 0.09470506,
          size.height * 0.1250000,
          size.width * 0.06909684,
          size.height * 0.1250000)
      ..lineTo(0, size.height * 0.1250000)
      ..lineTo(0, size.height * 0.8867773)
      ..lineTo(size.width * 0.02742665, size.height * 0.8867773)
      ..lineTo(size.width * 0.02742665, size.height * 0.6092727)
      ..lineTo(size.width * 0.05712627, size.height * 0.6092727)
      ..cubicTo(
          size.width * 0.06485443,
          size.height * 0.6092727,
          size.width * 0.07167278,
          size.height * 0.6419182,
          size.width * 0.07379430,
          size.height * 0.6898000)
      ..lineTo(size.width * 0.08031013, size.height * 0.8367136)
      ..cubicTo(
          size.width * 0.08121899,
          size.height * 0.8563045,
          size.width * 0.08197722,
          size.height * 0.8682773,
          size.width * 0.08349241,
          size.height * 0.8867773)
      ..lineTo(size.width * 0.1121310, size.height * 0.8867773)
      ..cubicTo(
          size.width * 0.1107671,
          size.height * 0.8639227,
          size.width * 0.1094038,
          size.height * 0.8443318,
          size.width * 0.1078886,
          size.height * 0.8084227)
      ..close()
      ..moveTo(size.width * 0.02742665, size.height * 0.4645364)
      ..lineTo(size.width * 0.02742665, size.height * 0.2751786)
      ..lineTo(size.width * 0.06349051, size.height * 0.2751786)
      ..cubicTo(
          size.width * 0.07546139,
          size.height * 0.2751786,
          size.width * 0.08212848,
          size.height * 0.3078259,
          size.width * 0.08212848,
          size.height * 0.3709445)
      ..cubicTo(
          size.width * 0.08212848,
          size.height * 0.4329750,
          size.width * 0.07546139,
          size.height * 0.4645364,
          size.width * 0.06349051,
          size.height * 0.4645364)
      ..lineTo(size.width * 0.02742665, size.height * 0.4645364)
      ..close()
      ..moveTo(size.width * 0.2204456, size.height * 0.8867773)
      ..lineTo(size.width * 0.2499937, size.height * 0.8867773)
      ..lineTo(size.width * 0.1993835, size.height * 0.1250000)
      ..lineTo(size.width * 0.1687747, size.height * 0.1250000)
      ..lineTo(size.width * 0.1181639, size.height * 0.8867773)
      ..lineTo(size.width * 0.1477120, size.height * 0.8867773)
      ..lineTo(size.width * 0.1571070, size.height * 0.7431273)
      ..lineTo(size.width * 0.2110513, size.height * 0.7431273)
      ..lineTo(size.width * 0.2204456, size.height * 0.8867773)
      ..close()
      ..moveTo(size.width * 0.1677139, size.height * 0.5809773)
      ..lineTo(size.width * 0.1840791, size.height * 0.3328559)
      ..lineTo(size.width * 0.2004443, size.height * 0.5809773)
      ..lineTo(size.width * 0.1677139, size.height * 0.5809773)
      ..close()
      ..moveTo(size.width * 0.3163019, size.height * 0.1250000)
      ..lineTo(size.width * 0.2597823, size.height * 0.1250000)
      ..lineTo(size.width * 0.2597823, size.height * 0.8867773)
      ..lineTo(size.width * 0.3163019, size.height * 0.8867773)
      ..cubicTo(
          size.width * 0.3517601,
          size.height * 0.8867773,
          size.width * 0.3738829,
          size.height * 0.7202727,
          size.width * 0.3738829,
          size.height * 0.5069773)
      ..cubicTo(
          size.width * 0.3738829,
          size.height * 0.2936786,
          size.width * 0.3517601,
          size.height * 0.1250000,
          size.width * 0.3163019,
          size.height * 0.1250000)
      ..close()
      ..moveTo(size.width * 0.3163019, size.height * 0.7126545)
      ..lineTo(size.width * 0.2878146, size.height * 0.7126545)
      ..lineTo(size.width * 0.2878146, size.height * 0.2991200)
      ..lineTo(size.width * 0.3163019, size.height * 0.2991200)
      ..cubicTo(
          size.width * 0.3341823,
          size.height * 0.2991200,
          size.width * 0.3453956,
          size.height * 0.3872682,
          size.width * 0.3453956,
          size.height * 0.5069773)
      ..cubicTo(
          size.width * 0.3453956,
          size.height * 0.6266818,
          size.width * 0.3341823,
          size.height * 0.7126545,
          size.width * 0.3163019,
          size.height * 0.7126545)
      ..close();
  }

  Path paintSecondPart(Size size) {
    return Path()
      ..moveTo(size.width * 0.8004620, size.height * 0.6033591)
      ..lineTo(size.width * 0.7988797, size.height * 0.6033591)
      ..lineTo(size.width * 0.7988797, size.height * 0.6147227)
      ..lineTo(size.width * 0.7988797, size.height * 0.8623591)
      ..lineTo(size.width * 0.7740127, size.height * 0.8623591)
      ..lineTo(size.width * 0.7740127, size.height * 0.1233132)
      ..lineTo(size.width * 0.8351646, size.height * 0.1233132)
      ..cubicTo(
          size.width * 0.8482468,
          size.height * 0.1233132,
          size.width * 0.8587342,
          size.height * 0.1470809,
          size.width * 0.8659177,
          size.height * 0.1885491)
      ..cubicTo(
          size.width * 0.8730570,
          size.height * 0.2297995,
          size.width * 0.8770696,
          size.height * 0.2893114,
          size.width * 0.8770696,
          size.height * 0.3633355)
      ..cubicTo(
          size.width * 0.8770696,
          size.height * 0.4373595,
          size.width * 0.8730570,
          size.height * 0.4968727,
          size.width * 0.8659177,
          size.height * 0.5381227)
      ..cubicTo(
          size.width * 0.8587342,
          size.height * 0.5795909,
          size.width * 0.8482468,
          size.height * 0.6033591,
          size.width * 0.8351646,
          size.height * 0.6033591)
      ..lineTo(size.width * 0.8004620, size.height * 0.6033591)
      ..close()
      ..moveTo(size.width * 0.7988797, size.height * 0.4623682)
      ..lineTo(size.width * 0.7988797, size.height * 0.4737318)
      ..lineTo(size.width * 0.8004620, size.height * 0.4737318)
      ..lineTo(size.width * 0.8321329, size.height * 0.4737318)
      ..cubicTo(
          size.width * 0.8380253,
          size.height * 0.4737318,
          size.width * 0.8429494,
          size.height * 0.4641545,
          size.width * 0.8464430,
          size.height * 0.4451700)
      ..cubicTo(
          size.width * 0.8499873,
          size.height * 0.4258891,
          size.width * 0.8518987,
          size.height * 0.3976895,
          size.width * 0.8518987,
          size.height * 0.3633355)
      ..cubicTo(
          size.width * 0.8518987,
          size.height * 0.3289814,
          size.width * 0.8499873,
          size.height * 0.3007818,
          size.width * 0.8464430,
          size.height * 0.2815009)
      ..cubicTo(
          size.width * 0.8429494,
          size.height * 0.2625164,
          size.width * 0.8380253,
          size.height * 0.2529409,
          size.width * 0.8321329,
          size.height * 0.2529409)
      ..lineTo(size.width * 0.8004620, size.height * 0.2529409)
      ..lineTo(size.width * 0.7988797, size.height * 0.2529409)
      ..lineTo(size.width * 0.7988797, size.height * 0.2643045)
      ..lineTo(size.width * 0.7988797, size.height * 0.4623682)
      ..close()
      ..moveTo(size.width * 0.9194051, size.height * 0.6033591)
      ..lineTo(size.width * 0.9178228, size.height * 0.6033591)
      ..lineTo(size.width * 0.9178228, size.height * 0.6147227)
      ..lineTo(size.width * 0.9178228, size.height * 0.8623591)
      ..lineTo(size.width * 0.8929557, size.height * 0.8623591)
      ..lineTo(size.width * 0.8929557, size.height * 0.1233132)
      ..lineTo(size.width * 0.9541013, size.height * 0.1233132)
      ..cubicTo(
          size.width * 0.9671899,
          size.height * 0.1233132,
          size.width * 0.9776772,
          size.height * 0.1470809,
          size.width * 0.9848544,
          size.height * 0.1885491)
      ..cubicTo(
          size.width * 0.9920000,
          size.height * 0.2297995,
          size.width * 0.9960127,
          size.height * 0.2893114,
          size.width * 0.9960127,
          size.height * 0.3633355)
      ..cubicTo(
          size.width * 0.9960127,
          size.height * 0.4373595,
          size.width * 0.9920000,
          size.height * 0.4968727,
          size.width * 0.9848544,
          size.height * 0.5381227)
      ..cubicTo(
          size.width * 0.9776772,
          size.height * 0.5795909,
          size.width * 0.9671899,
          size.height * 0.6033591,
          size.width * 0.9541013,
          size.height * 0.6033591)
      ..lineTo(size.width * 0.9194051, size.height * 0.6033591)
      ..close()
      ..moveTo(size.width * 0.9178228, size.height * 0.4623682)
      ..lineTo(size.width * 0.9178228, size.height * 0.4737318)
      ..lineTo(size.width * 0.9194051, size.height * 0.4737318)
      ..lineTo(size.width * 0.9510759, size.height * 0.4737318)
      ..cubicTo(
          size.width * 0.9569684,
          size.height * 0.4737318,
          size.width * 0.9618924,
          size.height * 0.4641545,
          size.width * 0.9653797,
          size.height * 0.4451700)
      ..cubicTo(
          size.width * 0.9689241,
          size.height * 0.4258891,
          size.width * 0.9708354,
          size.height * 0.3976895,
          size.width * 0.9708354,
          size.height * 0.3633355)
      ..cubicTo(
          size.width * 0.9708354,
          size.height * 0.3289814,
          size.width * 0.9689241,
          size.height * 0.3007818,
          size.width * 0.9653797,
          size.height * 0.2815009)
      ..cubicTo(
          size.width * 0.9618924,
          size.height * 0.2625164,
          size.width * 0.9569684,
          size.height * 0.2529409,
          size.width * 0.9510759,
          size.height * 0.2529409)
      ..lineTo(size.width * 0.9194051, size.height * 0.2529409)
      ..lineTo(size.width * 0.9178228, size.height * 0.2529409)
      ..lineTo(size.width * 0.9178228, size.height * 0.2643045)
      ..lineTo(size.width * 0.9178228, size.height * 0.4623682)
      ..close()
      ..moveTo(size.width * 0.7551835, size.height * 0.5472500)
      ..cubicTo(
          size.width * 0.7551835,
          size.height * 0.6464500,
          size.width * 0.7506899,
          size.height * 0.7280409,
          size.width * 0.7420063,
          size.height * 0.7849364)
      ..cubicTo(
          size.width * 0.7333038,
          size.height * 0.8419409,
          size.width * 0.7202025,
          size.height * 0.8754182,
          size.width * 0.7026709,
          size.height * 0.8754182)
      ..cubicTo(
          size.width * 0.6850570,
          size.height * 0.8754182,
          size.width * 0.6718038,
          size.height * 0.8419318,
          size.width * 0.6629684,
          size.height * 0.7848818)
      ..cubicTo(
          size.width * 0.6541519,
          size.height * 0.7279545,
          size.width * 0.6495506,
          size.height * 0.6463682,
          size.width * 0.6495506,
          size.height * 0.5472500)
      ..lineTo(size.width * 0.6495506, size.height * 0.1233132)
      ..lineTo(size.width * 0.6742658, size.height * 0.1233132)
      ..lineTo(size.width * 0.6742658, size.height * 0.5331045)
      ..cubicTo(
          size.width * 0.6742658,
          size.height * 0.5914500,
          size.width * 0.6767215,
          size.height * 0.6393818,
          size.width * 0.6816392,
          size.height * 0.6726455)
      ..cubicTo(
          size.width * 0.6865443,
          size.height * 0.7058182,
          size.width * 0.6936899,
          size.height * 0.7229409,
          size.width * 0.7026709,
          size.height * 0.7229409)
      ..cubicTo(
          size.width * 0.7114241,
          size.height * 0.7229409,
          size.width * 0.7183861,
          size.height * 0.7060727,
          size.width * 0.7231646,
          size.height * 0.6729545)
      ..cubicTo(
          size.width * 0.7279494,
          size.height * 0.6397818,
          size.width * 0.7303165,
          size.height * 0.5918636,
          size.width * 0.7303165,
          size.height * 0.5331045)
      ..lineTo(size.width * 0.7303165, size.height * 0.1233132)
      ..lineTo(size.width * 0.7551835, size.height * 0.1233132)
      ..lineTo(size.width * 0.7551835, size.height * 0.5472500)
      ..close();
  }

  Path paintFlash(Size size) {
    return Path()
      ..moveTo(size.width * 0.4394006, size.height * 0.3887868)
      ..cubicTo(
          size.width * 0.4392968,
          size.height * 0.3921509,
          size.width * 0.4394114,
          size.height * 0.3956718,
          size.width * 0.4397114,
          size.height * 0.3983591)
      ..cubicTo(
          size.width * 0.4400120,
          size.height * 0.4010464,
          size.width * 0.4404658,
          size.height * 0.4026100,
          size.width * 0.4409456,
          size.height * 0.4026100)
      ..lineTo(size.width * 0.4958133, size.height * 0.4026100)
      ..lineTo(size.width * 0.4317633, size.height * 0.9380136)
      ..lineTo(size.width * 0.4404494, size.height * 0.5920955)
      ..cubicTo(
          size.width * 0.4405323,
          size.height * 0.5887818,
          size.width * 0.4404070,
          size.height * 0.5853727,
          size.width * 0.4401063,
          size.height * 0.5827909)
      ..cubicTo(
          size.width * 0.4398057,
          size.height * 0.5802091,
          size.width * 0.4393608,
          size.height * 0.5787136,
          size.width * 0.4388918,
          size.height * 0.5787136)
      ..lineTo(size.width * 0.3883646, size.height * 0.5787136)
      ..lineTo(size.width * 0.4500582, size.height * 0.04353691)
      ..lineTo(size.width * 0.4394006, size.height * 0.3887868)
      ..close();
  }
}

// var paint = Paint()
//   ..style = PaintingStyle.stroke
//   ..strokeWidth = 0.5
//   ..color = BrandColors.green
//   ..strokeJoin = StrokeJoin.round;
// canvas.drawShadow(
//   path,
//   BrandColors.green.withAlpha(255),
//   5,
//   true,
// );
// canvas.drawPath(path, paint);
