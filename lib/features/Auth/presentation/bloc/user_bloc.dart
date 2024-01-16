import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/string/messages.dart';
import 'package:clean_architecture/features/Auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/Failure.dart';
import '../../../../core/string/failure.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/signin_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final LogOutUseCase logOutUseCase;
  UserBloc({required this.signUpUseCase, required this.signInUseCase, required this.logOutUseCase})
      : super(UserInitial()) {
    on<UserEvent>((event, emit) async{
      if(event is SignUpEvent){
        emit(LoadingState());

        final user = await signUpUseCase(event.user);
        user.fold(
                (failure){
                  emit(ErrorState(message: mapFailureToMessageInfo(failure)));
                },
                (user) {
                  emit(SuccessState(message: SIGN_IN_SUCCESS_MESSAGE));
                },
        );
      }else if (event is SignInEvent){
        emit(LoadingState());

        final user = await signInUseCase(event.user);
        user.fold(
              (failure){
            emit(ErrorState(message: mapFailureToMessageInfo(failure)));
          },
              (_) {
            emit(SuccessState(message: SIGN_UP_SUCCESS_MESSAGE));
          },
        );
      }else if (event is LogOutEvent){
        emit(LoadingState());

        final user = await logOutUseCase();
        user.fold(
              (failure){
            emit(ErrorState(message: mapFailureToMessageInfo(failure)));
          },
              (_) {
            emit(SuccessState(message: LOG_OUT_SUCCESS_MESSAGE));
          },
        );
      }
    });
  }


  String mapFailureToMessageInfo(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return "An Unexpected Wrong, Please try again later!.";
    }
  }
}
