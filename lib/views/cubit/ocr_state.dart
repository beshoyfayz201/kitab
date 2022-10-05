part of 'ocr_cubit.dart';

@immutable
abstract class OcrState {}

class OcrInitial extends OcrState {}

class OcrLoading extends OcrState {}

class OcrImageLoaded extends OcrState {}

class OcrSuccess extends OcrState {}

class OcrError extends OcrState {
  OcrError(Exception e) {
    print(e.toString());
  }
}
