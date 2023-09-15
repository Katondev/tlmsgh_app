import 'package:flutter/material.dart';
import 'package:katon/utils/config.dart';

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int position;

  final DotsDecorator decorator;

  const DotsIndicator({
    Key? key,
    required this.dotsCount,
    this.position = 0,
    this.decorator = const DotsDecorator(),
  })  : assert(dotsCount > 0),
        assert(position >= 0),
        assert(
          position < dotsCount,
          "Position must be inferior than dotsCount",
        ),
        super(key: key);

  Widget _buildDot(int i) {
    final color = (i == position) ? decorator.activeColor : decorator.color;
    final size = (i == position) ? decorator.activeSize : decorator.size;
    final shape = (i == position) ? decorator.activeShape : decorator.shape;

    return Container(
      width: size.width,
      height: size.height,
      margin: decorator.spacing,
      decoration: ShapeDecoration(color: color, shape: shape),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(dotsCount, _buildDot),
    );
  }
}

const Size kDefaultSize = Size.square(9.0);
const ShapeBorder kDefaultShape = CircleBorder();

class DotsDecorator {
  final Color color;
  final Color activeColor;
  final Size size;
  final Size activeSize;
  final ShapeBorder shape;
  final ShapeBorder activeShape;
  final EdgeInsets? spacing;

  const DotsDecorator({
    this.color = AppColors.white,
    this.activeColor = AppColors.gray909090,
    this.size = kDefaultSize,
    this.activeSize = kDefaultSize,
    this.shape = kDefaultShape,
    this.activeShape = kDefaultShape,
    this.spacing = all6,
  });
}
