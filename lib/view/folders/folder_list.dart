import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/folder_controller.dart';
import 'package:untitled/res/constants.dart';
import 'package:untitled/view/folders/widget/app_bar.dart';
import 'package:untitled/view/folders/widget/folder_list.dart';


class FolderList extends StatefulWidget {
  const FolderList({super.key});

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getList();
  }
  final controller = Get.put(FolderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(),
            Folders()
          ],
        ),
      ),
    );
  }
}
