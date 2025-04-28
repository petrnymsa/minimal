import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../chroma_counter/views/ui_states/chroma_counter_ui_state.dart';
import '../../bloc/chroma_counter_bloc.dart';
import '../widgets/chroma_counter_bloc_version.dart';

class ChromaCounterPageBloc extends StatelessWidget {
  const ChromaCounterPageBloc({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<ChromaCounterBloc>(
      create: (final context) => ChromaCounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chroma Counter BLOC'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 32,
            children: [
              const _SelectedCount(),
              const ChromaCounterBlocVersion(),
              Builder(
                builder: (final context) {
                  return ElevatedButton(
                    onPressed: () {
                      unawaited(
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (final _) => BlocProvider.value(
                            value: context.read<ChromaCounterBloc>(),
                            child: const _BottomSheetContent(),
                          ),
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.9,
                          ),
                          useSafeArea: true,
                        ),
                      );
                    },
                    child: const Text('Reveal'),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: const _Button(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class _SelectedCount extends StatelessWidget {
  const _SelectedCount();
  static final _formatter = DateFormat('mm:ss');

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ChromaCounterBloc, ChromaCounterUIState>(
      buildWhen: (final prev, final current) => prev.milestone != current.milestone,
      builder: (final context, final state) {
        final now = _formatter.format(DateTime.now());
        return Text(
          'Selected: ${state.milestone} at $now',
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent();

  @override
  Widget build(final BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 400,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: ChromaCounterBlocVersion(),
          ),
          Positioned(
            right: 16,
            bottom: 32,
            child: _Button(),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(final BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.read<ChromaCounterBloc>().add(const ChromaCounterEvent.nextMetamorph()),
      child: const Icon(Icons.refresh),
    );
  }
}
