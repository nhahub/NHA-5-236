part of 'root_bloc.dart';

abstract class RootEvent {}

class ChangeIndexRootEvent extends RootEvent {
  final int index;
  ChangeIndexRootEvent({required this.index});
}