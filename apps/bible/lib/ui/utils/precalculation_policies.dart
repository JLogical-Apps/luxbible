import 'package:super_sliver_list/super_sliver_list.dart';

class NumExtentPrecalculationPolicy extends ExtentPrecalculationPolicy {
  final int numItems;

  NumExtentPrecalculationPolicy({required this.numItems});

  @override
  bool shouldPrecalculateExtents(ExtentPrecalculationContext context) => context.numberOfItems < numItems;
}
