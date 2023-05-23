import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

List<XFile> images = [];
ImagePicker imagePicker = ImagePicker();

class PictureScreen extends StatefulWidget {
  const PictureScreen({super.key});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}


class _PictureScreenState extends State<PictureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Visibility(
                visible: images.isNotEmpty,
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SizedBox(
                                width: 300,
                                height: 300,
                                child: Image.file(
                                  File(images[index].path),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Positioned(
                            top: 6,
                            left: 6,
                            child: IconButton(
                              onPressed: () {
                                images.removeAt(index);
                                setState(() {});
                              },
                              icon: Icon(
                                CupertinoIcons.trash,
                                size: 35,
                                color: Colors.red.shade700,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: getImageFromCamera,
                          icon: const Icon(
                            CupertinoIcons.camera,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Text(
                          'دوربین',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            getImageFromGallery();
                          },
                          icon: const Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Text(
                          'گالری',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'ثبت',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
          Visibility(
            visible: false,
            child: Container(
              color: Colors.black38,
              height: double.infinity,
              width: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void getImageFromGallery() async {
    var multiImage = await imagePicker.pickMultiImage();
    if (multiImage.isNotEmpty) {
      for (var element in multiImage) {
        images.add(element);
      }
    }
    setState(() {});
  }

  void getImageFromCamera() async {
    var imageCamera = await imagePicker.pickImage(source: ImageSource.camera);
    if (imageCamera != null) {
      images.add(imageCamera);
    }
    setState(() {});
  }
}
