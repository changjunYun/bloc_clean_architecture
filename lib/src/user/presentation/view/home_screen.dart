import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is UserCreated) {
            context.read<UserCubit>().getUser();
          }
        },
        builder: (context, state) {
          if (state is GettingUsers) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text('생성일: ${user.createdAt}'),
                );
              },
            );
          }

          return const Center(child: Text('유저를 불러오는 중입니다...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserCubit>().createUser(
            createdAt: DateTime.now().toIso8601String(),
            name: 'CJ',
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}