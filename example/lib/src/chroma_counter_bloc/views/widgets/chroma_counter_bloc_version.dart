import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chroma_counter/views/ui_states/chroma_counter_ui_state.dart';
import '../../bloc/chroma_counter_bloc.dart';

class ChromaCounterBlocVersion extends StatelessWidget {
  const ChromaCounterBlocVersion({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ChromaCounterBloc, ChromaCounterUIState>(
      builder: (final context, final state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: state.backgroundColor,
            borderRadius: state.borderRadius,
          ),
          child: Center(
            child: Text(
              '${state.count}',
              style: const TextStyle(
                fontSize: 48,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
