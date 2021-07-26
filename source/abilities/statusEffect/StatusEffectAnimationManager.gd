extends Node2D

class_name StatusEffectAnimationManager

func setup(statusEffectManager : StatusEffectManager, sprite : Sprite) -> void:
	statusEffectManager.connect("effectAdded", self, "_on_effect_applied")
	statusEffectManager.connect("effectRemoved", self, "_on_effect_removed")
	for child in get_children():
		child.setActorSprite(sprite)

func _on_effect_applied(effect : StatusEffect) -> void:
	_playAnimation(effect)

func _on_effect_removed(effect : StatusEffect) -> void:
	_stopAnimation(effect)

func _playAnimation(effect : StatusEffect) -> void:
	var animation = get_node(effect.get_class())
	animation.play()

func _stopAnimation(effect : StatusEffect) -> void:
	var animation = get_node(effect.get_class())
	animation.stop()
