import 'package:flutter/material.dart';

import './tile.dart';

class Grid extends StatelessWidget {
  const Grid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double ratio = size.height / size.width;
    var side = 0.0;
    if (ratio < 1) {
      side = 500.0;
    } else if (ratio < 1.6) {
      side = 125.0;
    } else if (ratio < 1.7) {
      side = 60.0;
    } else {
      side = 36.0;
    }
    print('height = ${size.height}');
    print('width = ${size.width}');
    print('ratio = $ratio');
    print('side = $side');
    return GridView.builder(
        itemCount: 30,
        physics: const NeverScrollableScrollPhysics(),
        //padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),

        // padding: ratio > 1.7
        //     ? const EdgeInsets.fromLTRB(36, 10, 36, 20)
        //     : const EdgeInsets.fromLTRB(125, 10, 125, 20), // tested

        // padding: const EdgeInsets.fromLTRB(500, 10, 500, 20),

        padding: EdgeInsets.fromLTRB(side, 10, side, 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 5,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Tile(index: index),
            //child: SizedBox(),
          );
        });
  }
}
