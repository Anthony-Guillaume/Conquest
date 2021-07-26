extends Sprite

class_name StatusAnimation

onready var animation : AnimationPlayer = $AnimationPlayer
var _actorSprite : Sprite
var _initialActorSpriteColor : Color

func setActorSprite(actorSprite : Sprite) -> void:
	_actorSprite = actorSprite
	_initialActorSpriteColor = actorSprite.get_self_modulate()

func play() -> void:
	show()
	animation.play("run")

func stop() -> void:
	hide()
	animation.stop()
