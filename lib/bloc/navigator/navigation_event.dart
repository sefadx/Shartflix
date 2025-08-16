part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class PushPage extends NavigationEvent {
  final PageConfiguration page;

  PushPage(this.page);

  @override
  List<Object> get props => [page];
}

class PopPage extends NavigationEvent {}
class ReplacePage extends NavigationEvent {
  final PageConfiguration page;

  ReplacePage(this.page);

  @override
  List<Object> get props => [page];
}
class ReplaceAllPages extends NavigationEvent {
  final PageConfiguration page;

  ReplaceAllPages(this.page);

  @override
  List<Object> get props => [page];
}
class PushWidgetPage extends NavigationEvent {
  final Widget child;
  final PageConfiguration page;

  PushWidgetPage(this.child, this.page);

  @override
  List<Object> get props => [page];
}