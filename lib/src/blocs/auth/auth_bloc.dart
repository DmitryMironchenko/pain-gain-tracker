import 'package:bloc/bloc.dart';
import 'package:buttpaintracker/src/models/user.dart';
import 'package:meta/meta.dart';
import 'package:buttpaintracker/src/blocs/auth/auth_event.dart';
import 'package:buttpaintracker/src/blocs/auth/auth_state.dart';
import 'package:buttpaintracker/src/repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  // final _userFetcher = BehaviorSubject<FirebaseUserModel>();

  // Stream<FirebaseUserModel> get user => _userFetcher.stream;

  // getCurrentUser() async {
  //   FirebaseUserModel userModel = await _repository.getCurrentUser();
  //   _userFetcher.sink.add(userModel);
  // }

  // dispose() {
  //   _userFetcher.close();
  // }

  @override
  AuthState get initialState => AuthStateUnauthenticated();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is AuthEventAppStarted) {
      yield* _mapAppStartedEvent();
    } else if (event is AuthEventSignedIn) {
      yield* _mapSignedInEvent(
        user: event.user,
        isNew: event.isNew,
      );
    } else if (event is AuthEventSignedOut) {
      yield* _mapSignedOutEvent();
    }
  }

  Stream<AuthState> _mapAppStartedEvent() async* {
    final isSignedIn = await userRepository.isSignedIn();

    if (isSignedIn) {
      yield AuthStateLoading();
      final User user = await userRepository.getCurrentUser();
      yield AuthStateAuthenticated(user: user, isAutoLogIn: true);
    } else {
      yield AuthStateUnauthenticated();
    }
  }

  Stream<AuthState> _mapSignedInEvent({
    User user,
    bool isNew,
  }) async* {
    yield AuthStateAuthenticated(user: user, isNew: isNew);
  }

  Stream<AuthState> _mapSignedOutEvent() async* {
    yield AuthStateLoading();
    userRepository.signOut();
    yield AuthStateUnauthenticated();
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
  }
}
