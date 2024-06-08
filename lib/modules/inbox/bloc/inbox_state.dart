part of 'inbox_bloc.dart';

class InboxState extends Equatable {
  final bool isLoading;
  final Project inbox;

  const InboxState({
    this.isLoading = true,
    this.inbox = Project.empty,
  });

  @override
  List<Object> get props => [isLoading, inbox];

  InboxState copyWith({
    bool? isLoading,
    Project? inbox,
  }) {
    return InboxState(
      isLoading: isLoading ?? this.isLoading,
      inbox: inbox ?? this.inbox,
    );
  }

  @override
  bool get stringify => true;
}
