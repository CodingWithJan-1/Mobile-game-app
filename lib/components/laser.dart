import 'package:cosmic_shooter/components/asteroid.dart';
import 'package:cosmic_shooter/my_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Laser extends SpriteComponent with HasGameReference<MyGame>, CollisionCallbacks {
  Laser({required super.position})
      : super(
          anchor: Anchor.center,
          priority: -1,
        );

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('laser.png');
    size *= 0.25;

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y -= 500 * dt;

    // remove laser if it goes off the top of the screen
    if (position.y < -size.y / 2) {
      removeFromParent();
    }

    super.update(dt);
  }

  @override
  onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Asteroid) {
      // Remove both laser and asteroid on collision
      removeFromParent();
      other.takeDamage();
    }
  }
}