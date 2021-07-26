extends Node

class_name Animator

var _animation : AnimationPlayer
var _sprite : Sprite
var _actor
var _direction : Vector2

func get_class() -> String:
	 return "Animator"

func _process(_delta) -> void:
	pass

func setup(actor) -> void:
	_animation = actor.sprite.get_child(0)
	_sprite = actor.sprite
	_actor = actor
	_direction = actor.facingDirection
	actor.connect("stateChanged", self, "_on_actor_state_changed")
	actor.connect("faceDirectionChanged", self, "_on_actor_direction_changed")
	actor.skillSet.connect("skillActivated", self, "_on_skill_used")

func _on_skill_used(skillName : String) -> void:
	match skillName:
		"Fireball":
			_animation.play("right_arm_raised")
		"FireNova":
			_animation.play("both_arm_raised")
		"FireCrushing":
			_animation.play("both_arm_raised")
		"Dash":
			_animation.play("run")
		_:
			pass

func _on_actor_direction_changed(direction : Vector2) -> void:
	_sprite.rotate(_direction.angle_to(direction))
	_direction = direction

func _on_actor_state_changed(state : int) -> void:
	if state == 0:
		var angle : float = _actor.velocity.angle_to(_actor.facingDirection)
		if abs(angle) < PI * 0.25 or abs(angle + PI) < PI * 0.25:
			_animation.play("run")
		elif angle > 0:
			_animation.play("side_step_left")
		else:
			_animation.play("side_step_right")
	else:
		_animation.play("idle")
