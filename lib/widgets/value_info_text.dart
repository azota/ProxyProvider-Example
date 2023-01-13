import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/value_info.dart';

class ValueInfoText extends StatelessWidget {
  const ValueInfoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valueInfo = context.watch<ValueInfoModel>();
    return Text(valueInfo.infoString);
  }
}
