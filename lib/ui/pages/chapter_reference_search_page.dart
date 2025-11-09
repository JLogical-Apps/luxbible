import 'package:bible/models/chapter_reference.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/ui/pages/styled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChapterReferenceSearchPage extends HookConsumerWidget {
  final ChapterReference initialReference;

  const ChapterReferenceSearchPage({super.key, required this.initialReference});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookTextState = useState(initialReference.book.title());
    final chapterTextState = useState<int?>(initialReference.chapterNum);

    return Scaffold(
      backgroundColor: context.colors.surfacePrimary,
      appBar: AppBar(
        backgroundColor: context.colors.surfacePrimary,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: StyledTextField(
                    text: bookTextState.value,
                    onChanged: (text) => bookTextState.value = text,
                    autofocus: true,
                    hintText: 'Book',
                    textStyle: context.textStyle.paragraphLarge,
                    textCapitalization: TextCapitalization.words,
                    action: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: StyledTextField(
                    text: chapterTextState.value?.toString() ?? '',
                    onChanged: bookTextState.value.isEmpty
                        ? null
                        : (text) => chapterTextState.value = int.tryParse(text),
                    hintText: 'Chapter',
                    textStyle: context.textStyle.paragraphLarge,
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
