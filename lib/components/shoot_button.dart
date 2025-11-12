import 'package:cosmic_shooter/my_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class ShootButton extends SpriteComponent with HasGameReference<MyGame>, TapCallbacks{

  ShootButton() : super(size: Vector2.all(80));

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('shoot_button.png');
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    game.player.startShooting();
  }

  @override
  void onTapUp(TapUpEvent event) {
    // TODO: implement onTapUp
    super.onTapUp(event);

    game.player.stopShooting();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    // TODO: implement onTapCancel
    super.onTapCancel(event);

    game.player.stopShooting();
  }
}