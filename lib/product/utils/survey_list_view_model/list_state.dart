part of 'list_viewmodel.dart';

enum ListStatus { initial, loading, error, loaded, updated }

class ListState extends Equatable {
  const ListState({required this.state, this.message, this.surveys});

  final ListStatus state;
  final String? message;
  final List<Survey>? surveys;

  @override
  operator ==(Object other) =>
      other is ListState &&
      other.state == state &&
      other.message == message &&
      listEquals(other.surveys, surveys);

  @override
  int get hashCode => hashValues(state, message, hashList(surveys));

  @override
  List<Object?> get props => [state, message, surveys];

  ListState copyWith(
      {ListStatus? state, String? message, List<Survey>? surveys}) {
    return ListState(
        state: state ?? this.state,
        message: message ?? this.message,
        surveys: surveys ?? this.surveys);
  }
}
