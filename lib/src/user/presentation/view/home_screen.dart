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
          } else if (state is UserCreated || state is UserUpdated || state is UserDeleted) {
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
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        final TextEditingController nameController = TextEditingController(text: user.name);
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            left: 16,
                            right: 16,
                            top: 24,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('사용자 정보 수정', style: Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 12),
                              TextField(
                                controller: nameController,
                                decoration: const InputDecoration(labelText: '이름'),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {
                                  String _two(int n) => n.toString().padLeft(2, '0');

                                  final now = DateTime.now().toUtc().add(const Duration(hours: 9));
                                  final formatted = '${now.year}-${_two(now.month)}-${_two(now.day)} '
                                      '${_two(now.hour)}:${_two(now.minute)}:${_two(now.second)}';

                                  Navigator.pop(context);
                                  context.read<UserCubit>().updateUser(
                                    id: state.users[index].id,
                                    updatedAt: formatted,
                                    name: nameController.text,
                                  );
                                },
                                child: const Text('수정하기'),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(user.name),
                          Text('생성일: ${user.createdAt}'),
                          Text('최근 수정일 : ${user.updatedAt}')
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          context.read<UserCubit>().deleteUser(id: state.users[index].id);
                        },
                        child: SizedBox(
                          child: Icon(Icons.delete),
                        ),
                      )
                    ],
                  ),
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