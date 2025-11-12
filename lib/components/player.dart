import 'dart:async';
//import 'package:cosmic_shooter/components/asteroid.dart';
import 'package:cosmic_shooter/components/laser.dart';
import 'package:cosmic_shooter/my_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class Player extends SpriteComponent with HasGameReference<MyGame> {
  bool _isShooting = false;
  final double _fireCooldown = 0.2;
  double _elapsedFireTime = 0.0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('player_blue_on0.png');

    size *= 0.3;

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += game.joystick.relativeDelta.normalized() * 200 * dt;

    _handleScreenBounds();

    _elapsedFireTime += dt;
    if (_isShooting && _elapsedFireTime >= _fireCooldown) {
      _fireLaser();
      _elapsedFireTime = 0.0;
    }
  }

  // Keep the player within the screen bounds

  void _handleScreenBounds() {
    final double screenWidth = game.size.x;
    final double screenHeight = game.size.y;

    // prevent player from going off the top of bottom edges
    position.y = clampDouble(
      position.y,
      size.y / 2,
      screenHeight - size.y / 2
    );

    // perform wraparound when player goes over to the left or right edge
     if (position.x < 0 ) {
       position.x = screenWidth;
     } else if (position.x > screenWidth) {
      position.x = 0;
     }

  }

  void startShooting() {
    _isShooting = true;
  }

  void stopShooting() {
    _isShooting = false;
  }

  void _fireLaser() {
    game.add(Laser(position: position.clone() + Vector2(0, -size.y / 2)),
    );
  }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   // TODO: implement onCollision
  //   super.onCollision(intersectionPoints, other);

  //   if (other is Asteroid) {
  //     removeFromParent();
  //     other.removeFromParent();
  //     debugPrint('Player hit by asteroid!');
  //   }
  // }
}