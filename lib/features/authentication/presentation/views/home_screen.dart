import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arc/features/authentication/domain/usecases/create_user.dart';
import 'package:flutter_clean_arc/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_clean_arc/features/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:flutter_clean_arc/features/authentication/presentation/widgets/loading_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getUsers() {
    context.read<AuthenticationCubit>().getUserHandler();
  }

  var nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is UserCreatedState) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUserState
              ? const LoadingWidget(
                  message: "Fetching users..",
                )
              : state is UserCreatedState
                  ? const LoadingWidget(message: "Creating User..")
                  : state is UserLoadedState
                      ? Center(
                          child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                var user = state.users[index];

                                return ListTile(
                                  leading: Image.network(user.avatar),
                                  title: Text(user.name),
                                  subtitle: Text(user.createdAt.substring(10)),
                                );
                              }),
                        )
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (ctx) => AddUserDialog(
                  nameController: nameController,
                ),
              );

              // context.read<AuthenticationCubit>().createUserHandler(
              //       DateTime.now().toString(),
              //       "Ujang",
              //       "ava",
              //     );
            },
            label: const Text("Add User"),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
