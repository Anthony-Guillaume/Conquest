extends Area2D

class_name SuicideExplosion

var damage : float = 50
var _shooter = null
onready var animation : SkillAnimation = $Sprite

func get_class() -> String:
	return "SuicideExplosion"

func _ready() -> void:
	animation.animationPlayer.connect("animation_finished", self, "_on_animation_finished")
	yield(get_tree().create_timer(0.05), "timeout") # waiting for get_overlapping_bodies() to get ready
	animation.play()
	$AudioStreamPlayer2D.play()
	_explode()

func setup(shooter, globalPosition : Vector2, skillDirection : Vector2, shooterMuzzle : float) -> void:
	global_position = globalPosition
	_shooter = shooter

func _explode() -> void:
	_damageBodyInArea()

func _damageBodyInArea() -> void:
	for target in get_overlapping_bodies():
		if target != _shooter and Algorithm.doesRayCastFirstHitTarget(global_position, _shooter, target):
			Rules.applyDamage(_shooter, target, damage)

func _on_animation_finished(_animationName : String) -> void:
	_shooter.queue_free()
