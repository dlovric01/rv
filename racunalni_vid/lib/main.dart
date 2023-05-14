import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:racunalni_vid/camera_cubit/camera_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const CameraApp());
}

class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late final CameraCubit _cameraCubit = CameraCubit()
    ..initController()
    ..clearState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => _cameraCubit,
        child: Material(
          child: WillPopScope(
            onWillPop: () async {
              await _cameraCubit.clearState();
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('FACE RECOGNITION'),
                toolbarHeight: 30,
              ),
              body: LoaderOverlay(
                child: Builder(builder: (context) {
                  return BlocListener<CameraCubit, CameraState>(
                    listener: (context, state) {
                      state.when(
                        imageState:
                            (file, isLoading, controller, _, faceNotFound) {
                          if (faceNotFound) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              'Face not found',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )));
                          }
                          if (state.isLoading) {
                            context.loaderOverlay.show();
                          } else {
                            context.loaderOverlay.hide();
                          }
                        },
                      );
                    },
                    child: BlocBuilder<CameraCubit, CameraState>(
                      builder: (context, state) {
                        return state.when(
                          imageState: (file, _, controller, __, ___) {
                            if (file == null && controller != null) {
                              return CameraWidget(
                                controller: controller,
                                cameraCubit: _cameraCubit,
                              );
                            } else if (file != null) {
                              return GeneratedImagePreview(
                                file: file,
                                cameraCubit: _cameraCubit,
                              );
                            } else {
                              return const LoadingIndicator();
                            }
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GeneratedImagePreview extends StatelessWidget {
  const GeneratedImagePreview({
    super.key,
    required this.file,
    required this.cameraCubit,
  });
  final File file;
  final CameraCubit cameraCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      builder: (context, state) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.file(
                  File(file.path),
                ),
                if (state.name != null && !state.faceNotFound)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      state.name!,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  )
              ],
            ),
            IconButton(
                onPressed: () {
                  cameraCubit.clearState();
                },
                icon: const Icon(Icons.arrow_back))
          ],
        );
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
            height: 50, width: 50, child: CircularProgressIndicator()));
  }
}

class CameraWidget extends StatelessWidget {
  const CameraWidget({
    super.key,
    required this.controller,
    required this.cameraCubit,
  });

  final CameraController controller;
  final CameraCubit cameraCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CameraPreview(
          controller,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextButton(
                  onPressed: () async {
                    cameraCubit.takePicture();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.camera_alt)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
