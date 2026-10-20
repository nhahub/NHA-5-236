part of 'root_bloc.dart';

abstract class RootState {}

class RootInitial extends RootState {}

class ChangeIndexRootState extends RootState {
  final int index;
  ChangeIndexRootState({required this.index});
}