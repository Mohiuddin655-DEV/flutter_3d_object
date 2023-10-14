import 'package:flutter/material.dart';
import 'package:flutter_3d_object/flutter_3d_object.dart';

class Ruby extends StatefulWidget {
  const Ruby({
    super.key,
  });

  @override
  State<Ruby> createState() => _RubyState();
}

class _RubyState extends State<Ruby> with SingleTickerProviderStateMixin {
  void _onSceneCreated(Scene scene) {
    scene.camera.position.z = 10;
    scene.camera.target.y = 2;
    // from https://sketchfab.com/3d-models/ruby-rose-2270ee59d38e409491a76451f6c6ef80
    scene.world.add(Object(
        scale: Vector3(10.0, 10.0, 10.0),
        fileName: 'assets/ruby_rose/ruby_rose.obj'));
  }

  @override
  Widget build(BuildContext context) {
    return Cube(
      onSceneCreated: _onSceneCreated,
    );
  }
}
