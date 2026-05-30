class InterlinearData {
  final int originalPosition;
  final String? inflection;
  final String? strongId;
  final String? morphology;

  const InterlinearData({required this.originalPosition, required this.inflection, this.strongId, this.morphology});
}
