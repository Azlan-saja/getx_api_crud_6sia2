import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_crud_6sia2/controllers/user_controller.dart';
import 'user_add_page.dart';
import 'user_edit_page.dart';

class UserListPage extends StatelessWidget {
  UserListPage({super.key});

  final userC = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Data User (CRUD GetX + API)')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(() => UserAddPage());
        },
        child: Icon(Icons.add),
      ),
      body: Obx(() {
        if (userC.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: userC.users.length,
          itemBuilder: (context, index) {
            final user = userC.users[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(child: Text(user.name.substring(0, 1))),
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => UserEditPage(user: user));
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: Text('Info Hapus,'),
                            content: Text('Yakin hapus data ${user.name}?'),
                            actions: [
                              TextButton(onPressed: () => Get.back(), child: Text('Batal')),
                              ElevatedButton(
                                onPressed: () {
                                  userC.deleteUser(user.id);
                                  Get.back();
                                },
                                child: Text('Hapus'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
