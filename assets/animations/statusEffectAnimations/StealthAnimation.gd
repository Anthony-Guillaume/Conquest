extends StatusAnimation

class_name StealthAnimation

func play() -> void:
	var color : Color = _initialActorSpriteColor
	color.a = 0.1
	_actorSprite.set_self_modulate(color)

func stop() -> void:
	_actorSprite.set_self_modulate(_initialActorSpriteColor)
