import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chroma_counter/views/ui_states/chroma_counter_ui_state.dart';

part 'chroma_counter_event.dart';

class ChromaCounterBloc extends Bloc<ChromaCounterEvent, ChromaCounterUIState> {
  ChromaCounterBloc() : super(const ChromaCounterUIState()) {
    on<ChromaNextMetamorphEvent>(_onNextMetamorph);
  }
  static final _random = math.Random();

  Future<void> _onNextMetamorph(
    final ChromaNextMetamorphEvent event,
    final Emitter<ChromaCounterUIState> emit,
  ) async {
    emit(
      state.copyWith(
        count: state.count + 1,
        backgroundColor: _randomColor(),
        borderRadius: _randomRadius(),
      ),
    );
  }

  Color _randomColor() => Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        1,
      );

  BorderRadius _randomRadius() => BorderRadius.only(
        topLeft: Radius.circular(_random.nextDouble() * 100),
        topRight: Radius.circular(_random.nextDouble() * 100),
        bottomLeft: Radius.circular(_random.nextDouble() * 100),
        bottomRight: Radius.circular(_random.nextDouble() * 100),
      );
}
