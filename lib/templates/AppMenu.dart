
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utils//globals.dart' as globals;

Widget buildIconNavBar(
  BuildContext context,
) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    child: Padding(
      padding: const EdgeInsets.only(left: 0, top: 10, right: 0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Icon(
                MdiIcons.homeVariant,
                color: globals.yellowColor,
                size: 20,
              ),
              Icon(
                MdiIcons.homeVariant,
                color: Color(0xFF999999),
                size: 20,
              ),
              Icon(
                MdiIcons.homeVariant,
                color: Color(0xFF999999),
                size: 20,
              ),
              Icon(
                MdiIcons.homeVariant,
                color: Color(0xFF999999),
                size: 20,
              ),
            Icon(
              MdiIcons.homeVariant,
              color: Color(0xFF999999),
              size: 20,
            ),
          ]),
    ),
  );
}
