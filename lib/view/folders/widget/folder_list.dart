import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/controller/folder_controller.dart';
import '../../audio_list/file_list.dart';
import '../../common_widget/soft_control.dart';

class Folders extends StatefulWidget {
  const Folders({super.key});

  @override
  State<Folders> createState() => _FoldersState();
}

class _FoldersState extends State<Folders> {
  final controller = Get.put(FolderController());
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 50), () {
      for (int i = 0; i < controller.folderList.length; i++) {
        _insertItemWithDelay(i);
      }
    });
  }

  void _insertItemWithDelay(int index) {
    Timer(Duration(milliseconds: index * 50), () {
      _key.currentState!.insertItem(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.folderList.isEmpty
        ? const Expanded(
            child: Center(
            child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ))
        : Expanded(
            child: AnimatedList(
              key: _key,
              initialItemCount: 0,
              itemBuilder: (context, index, animation) {
                if (controller.folderList[index].toString().length < 50) {
                  final slideAnimation = Tween<Offset>(
                    begin:
                        index % 2 == 0 ? Offset(-1.0, 0.0) : Offset(1.0, 0.0),
                    end: Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                      0.0,
                      1.0,
                      curve: Curves
                          .easeOut, // You can change the animation curve here
                    ),
                  ));
                  return SlideTransition(
                    position: slideAnimation,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => AudioList(
                              path: controller.folderList[index],
                            ));
                      },
                      child: Container(
                        height: 75,
                        width: MediaQuery.sizeOf(context).width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircularSoftButton(
                              radius: 25,
                              icon: const Icon(
                                Icons.folder,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              controller.folderList[index].toString().substring(
                                    controller.folderList[index]
                                            .toString()
                                            .indexOf('0') +
                                        2,
                                  ),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ));
  }
}
