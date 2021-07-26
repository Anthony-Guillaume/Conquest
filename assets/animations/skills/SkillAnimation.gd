extends Sprite

class_name SkillAnimation

# Default delay beetween frame = 0.04 s

onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func play() -> void:
	$AnimationPlayer.get_animation("run").set_loop(false)
	$AnimationPlayer.play("run")

func playInLoop() -> void:
	$AnimationPlayer.get_animation("run").set_loop(true)
	$AnimationPlayer.play("run")

func setLenght(length : float) -> void:
	$AnimationPlayer.get_animation("run").set_length(length)
