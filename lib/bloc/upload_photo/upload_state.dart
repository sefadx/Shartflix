part of 'upload_bloc.dart';

class UploadState extends Equatable {
  const UploadState();
  @override
  List<Object?> get props => [];
}

class Uploading extends UploadState {}

class UploadFailed extends UploadState {
  final String error;
  const UploadFailed(this.error);
  @override
  List<Object?> get props => [error];
}

class Uploaded extends UploadState {}
