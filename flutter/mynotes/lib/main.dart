import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/utils/dialogs/error_dialog.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/create_update_note_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.deepPurple,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            actionsIconTheme: IconThemeData(
              color: Colors.white,
            )),
        popupMenuTheme: const PopupMenuThemeData(
          iconColor: Colors.white,
          iconSize: 30,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      notesRoute: (context) => const NotesView(),
      createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView()
    },
  ));
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: AuthService.firebase().initialiaze(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState != ConnectionState.done) {
//           return const Scaffold(body: CircularProgressIndicator());
//         }
//         final AuthUser? user = AuthService.firebase().currentUser;
//         if (user == null) {
//           return const LoginView();
//         }
//         if (user.isEmailVerified) {
//           return const NotesView();
//         }
//         return const VerifyEmailView();
//       },
//     );
//   }
// }

@immutable
abstract class CounterState {
  final int value;

  const CounterState({required this.value});
}

class CounterStateValid extends CounterState {
  const CounterStateValid({required super.value});
}

class CounterStateInvalidNumber extends CounterState {
  final String invalidValue;
  const CounterStateInvalidNumber({
    required this.invalidValue,
    required int previousValue,
  }) : super(value: previousValue);
}

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent({required this.value});
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent({required super.value});
}

class DecrementEvent extends CounterEvent {
  const DecrementEvent({required super.value});
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateValid(value: 0)) {
    on<IncrementEvent>(
      (event, emit) {
        final integer = int.tryParse(event.value);
        if (integer == null) {
          emit(CounterStateInvalidNumber(
            invalidValue: event.value,
            previousValue: state.value,
          ));
        } else {
          emit(CounterStateValid(value: state.value + integer));
        }
      },
    );
    on<DecrementEvent>(
      (event, emit) {
        final integer = int.tryParse(event.value);
        if (integer == null) {
          emit(CounterStateInvalidNumber(
            invalidValue: event.value,
            previousValue: state.value,
          ));
        } else {
          emit(CounterStateValid(value: state.value - integer));
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        body: BlocConsumer<CounterBloc, CounterState>(
          listener: (context, state) {
            _textEditingController.clear();
          },
          builder: (context, state) {
            final invalidInput =
                (state is CounterStateInvalidNumber) ? state.invalidValue : '';
            return Column(
              children: [
                Text('Current value: ${state.value}'),
                Visibility(
                  visible: invalidInput.isNotEmpty,
                  child: Text('Invalid Input: $invalidInput'),
                ),
                TextField(
                  controller: _textEditingController,
                  decoration:
                      const InputDecoration(hintText: 'Please enter a number'),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(
                              IncrementEvent(
                                value: _textEditingController.text,
                              ),
                            );
                      },
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(
                              DecrementEvent(
                                value: _textEditingController.text,
                              ),
                            );
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
