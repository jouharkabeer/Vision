import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'inapp_viewmodel.dart';

class InAppView extends StatelessWidget {
  const InAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InAppViewModel>.reactive(
      // onViewModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) {
        // print(model.node?.lastSeen);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Smartphone'),
            actions: [
              IconButton(
                onPressed: () {
                  print("icon b");
                  model.speak("This is test speech output");
                },
                icon: Icon(Icons.volume_up),
              ),
            ],
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  model.getImageCamera();
                },
                tooltip: 'camera',
                child: Icon(Icons.add_a_photo),
                heroTag: null,
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                onPressed: () {
                  model.getImageGallery();
                },
                tooltip: 'camera',
                child: Icon(Icons.image),
                heroTag: null,
              )
            ],
          ),
          body: model.isBusy
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Container(
                      child: model.imageSelected != null
                          ? Column(
                              children: [
                                Expanded(
                                    child: Image.file(model.imageSelected!)),
                                if (model.labels.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      model.labels.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                TextButton(
                                  onPressed: () {
                                    model.getLabel();
                                    print("get label");
                                  },
                                  child: Text(
                                    "Get label",
                                  ),
                                ),
                              ],
                            )
                          : Text("No images selected!")
                      // Image.network("http://192.168.29.199/")
                      ),
                ),
        );
      },
      viewModelBuilder: () => InAppViewModel(),
    );
  }
}
