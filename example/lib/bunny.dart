import 'package:flutter/material.dart';
import 'package:flutter_3d_object/flutter_3d_object.dart';

class Bunny extends StatefulWidget {
  const Bunny({super.key});

  @override
  State<Bunny> createState() => _BunnyState();
}

class _BunnyState extends State<Bunny> with SingleTickerProviderStateMixin {
  late Scene _scene;
  Object? _bunny;
  late AnimationController _controller;
  final double _ambient = 0.1;
  double _diffuse = 0.8;
  double _specular = 0.5;
  double _shininess = 0.0;

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    scene.camera.position.z = 10;
    scene.light.position.setFrom(Vector3(0, 10, 10));
    scene.light.setColor(Colors.white, _ambient, _diffuse, _specular);
    _bunny = Object(
      position: Vector3(0, -1.0, 0),
      scale: Vector3(10.0, 10.0, 10.0),
      lighting: true,
      fileName: 'assets/bunny/bunny.obj',
    );
    scene.world.add(_bunny!);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 30000),
      vsync: this,
    )
      ..addListener(() {
        if (_bunny != null) {
          _bunny!.rotation.y = _controller.value * 360;
          _bunny!.updateTransform();
          _scene.update();
        }
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Cube(onSceneCreated: _onSceneCreated),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Flexible(flex: 2, child: Text('diffuse')),
                Flexible(
                  flex: 8,
                  child: Slider(
                    value: _diffuse,
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    onChanged: (value) {
                      setState(() {
                        _diffuse = value;
                        _scene.light.setColor(
                            Colors.white, _ambient, _diffuse, _specular);
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Flexible(flex: 2, child: Text('specular')),
                Flexible(
                  flex: 8,
                  child: Slider(
                    value: _specular,
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    onChanged: (value) {
                      setState(() {
                        _specular = value;
                        _scene.light.setColor(
                            Colors.white, _ambient, _diffuse, _specular);
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Flexible(flex: 2, child: Text('shininess')),
                Flexible(
                  flex: 8,
                  child: Slider(
                    value: _shininess,
                    min: 0.0,
                    max: 32.0,
                    divisions: 32,
                    onChanged: (value) {
                      setState(() {
                        _shininess = value;
                        _bunny!.mesh.material.shininess = _shininess;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ],
    );
  }
}
