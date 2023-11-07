import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      // onViewModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) {
        // print(model.node?.lastSeen);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Vision'),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      Option(
                          name: 'Camera',
                          onTap: model.openInAppView,
                          file: 'assets/lottie/inapp.json'),
                      Option(
                          name: 'Gallery',
                          onTap: model.openHardwareView,
                          file: 'assets/lottie/gallery.json'),
                      Option(
                          name: 'Live Camera',
                          onTap: model.openLiveView,
                          file: 'assets/lottie/live.json'),
                      Option(
                          name: 'Face Train',
                          onTap: model.openFaceTrainView,
                          file: 'assets/lottie/face.json'),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class Option extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final String file;
  const Option(
      {Key? key, required this.name, required this.onTap, required this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 1.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Lottie.asset(file),
                      )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
