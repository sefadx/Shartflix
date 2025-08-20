part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {}

class UploadPhoto extends UploadEvent {
  final String filePath;
  UploadPhoto({required this.filePath});
  @override
  List<Object?> get props => [];
}
