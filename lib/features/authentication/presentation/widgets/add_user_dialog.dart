import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arc/features/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({
    required this.nameController,
    super.key,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().createUserHandler(
                        DateTime.now().toString(),
                        nameController.text.trim(),
                        "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/625.jpg",
                      );
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
