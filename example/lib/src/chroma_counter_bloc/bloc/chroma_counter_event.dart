part of 'chroma_counter_bloc.dart';

@immutable
sealed class ChromaCounterEvent {
  const ChromaCounterEvent();

  const factory ChromaCounterEvent.nextMetamorph() = ChromaNextMetamorphEvent;
}

final class ChromaNextMetamorphEvent extends ChromaCounterEvent {
  const ChromaNextMetamorphEvent();
}
