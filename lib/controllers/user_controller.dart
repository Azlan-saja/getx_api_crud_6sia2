import 'package:get/get.dart';
import 'package:getx_api_crud_6sia2/models/user_model.dart';
import 'package:getx_api_crud_6sia2/services/api_service.dart';

class UserController extends GetxController {
  final service = ApiService();
  var users = <UserModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  // C  => Create => Menambahkan Data User Baru [POST]
  void addUser(String name, String email) async {
    final newUser = await service.createUser(name, email);
    if (newUser != null) {
      users.add(newUser);
      Get.back();
      Get.snackbar("Sukses", "User berhasil ditambahkan");
    } else {
      Get.snackbar("Gagal", "Gagal menambahkan user");
    }
  }

  // R  => Read   => Menampilkan Data User [GET]
  void fetchUsers() async {
    isLoading.value = true;
    final data = await service.getUsers();
    users.assignAll(data);
    isLoading.value = false;
  }

  // U  => Update => Memperbarui/edit Data User [PUT]
  void editUser(int id, String name, String email) async {
    final success = await service.updateUser(id, name, email);
    if (success || id > 10) {
      int index = users.indexWhere((u) => u.id == id);
      users[index] = UserModel(id: id, name: name, email: email);
      users.refresh();
      Get.back();
      Get.snackbar("Sukses", "User berhasil diperbarui");
    } else {
      Get.snackbar("Gagal", "Gagal memperbarui user");
    }
  }

  // D  => Delete => Menghapus Data User [DELETE]
  void deleteUser(int id) async {
    final success = await service.deleteUser(id);
    if (success) {
      users.removeWhere((u) => u.id == id);
      Get.snackbar("Sukses", "User terhapus");
    } else {
      Get.snackbar("Gagal", "Gagal menghapus user");
    }
  }
}
