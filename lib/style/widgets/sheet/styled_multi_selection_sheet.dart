import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart' hide MapExtensions;
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class StyledMultiSelectionSheet<T> extends StyledSheet<List<T>> {
  final Map<String?, List<T>> optionsByCategory;
  final List<T> initialOptions;
  final StyledSelectOption<T> Function(T) optionMapper;

  final Widget Function(BuildContext context, List<T> selectedOptions, Function(List<T>) updateSelectedOptions)?
  aboveButtonsBuilder;

  final List<String> Function(T)? searchKeywordsMapper;

  const StyledMultiSelectionSheet({
    super.key,
    required super.title,
    super.trailing,
    required this.optionsByCategory,
    this.initialOptions = const [],
    required this.optionMapper,
    this.aboveButtonsBuilder,
    this.searchKeywordsMapper,
  });

  @override
  Widget build(BuildContext context) {
    final searchKeywordsMapper = this.searchKeywordsMapper;

    final selectedOptionsState = useState(initialOptions);
    final searchState = useState('');

    return StyledSheet(
      title: title,
      trailing: trailing,
      aboveButtons: Column(
        children: [
          if (aboveButtonsBuilder case final aboveButtonsBuilder?)
            aboveButtonsBuilder(context, selectedOptionsState.value, (options) => selectedOptionsState.value = options),
          if (searchKeywordsMapper != null)
            Padding(
              padding: EdgeInsets.all(16),
              child: StyledTextField(
                text: searchState.value,
                onChanged: (text) => searchState.value = text,
                hintText: 'Search',
              ),
            ),
        ],
      ),
      buttonsBuilder: (context) => [
        StyledRectButton.primary(onPressed: () => context.pop(selectedOptionsState.value), label: 'Save'.toText()),
      ],
      children:
          optionsByCategory
              .mapValues(
                (category, options) => options
                    .where(
                      (option) =>
                          searchKeywordsMapper == null ||
                          searchState.value.isEmpty ||
                          searchState.value.passesSearch(searchKeywordsMapper(option)),
                    )
                    .toList(),
              )
              .where((category, options) => options.isNotEmpty)
              .mapToIterable((group, options) {
                final children = options
                    .map(
                      (option) => StyledListItem.checkbox(
                        title: optionMapper(option).title,
                        subtitle: optionMapper(option).subtitle,
                        leading: optionMapper(option).leading,
                        isSelected: selectedOptionsState.value.contains(option),
                        onSelected: (selected) =>
                            selectedOptionsState.value = selectedOptionsState.value.withToggle(option),
                      ),
                    )
                    .toList();
                return group == null
                    ? StyledList(children: children)
                    : StyledSection(title: Text(group), padding: .only(top: 24), children: children);
              })
              .nullIfEmpty
              ?.toList() ??
          [
            Padding(
              padding: .all(16),
              child: StyledTile.message(
                title: 'No Search Results Found'.toText(),
                subtitle: 'Try another search'.toText(),
                leading: Symbols.search.toIcon(),
              ),
            ),
          ],
    );
  }
}
