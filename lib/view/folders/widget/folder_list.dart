
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/folder_controller.dart';
import '../../common_widget/soft_control.dart';
import '../../Home/file_list.dart';

class Folders extends StatelessWidget {
   Folders({super.key});

  final controller = Get.put(FolderController());

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Expanded(
          child: ListView.builder(
            itemCount: controller.folderList.length,
            itemBuilder: (context, index) {
              if (controller.folderList[index].toString().length < 50) {
                return GestureDetector(
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
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
