extends Area2D

class_name Fireball

var damage : float = 20.0
var speed : float = 320.0
var _velocity : Vector2
var _shooter = null

var burningDamage : float = 5.0
var burningPeriodNumber : int = 3
var burningPeriodDuration : float = 1.0

onready var animation : SkillAnimation = $Sprite

func _ready() -> void:
	animation.playInLoop()
	$AudioStreamPlayer2D.play()

func setup(shooter, globalPosition : Vector2, skillDirection : Vector2, shooterMuzzle : float) -> void:
	global_position = globalPosition + skillDirection * shooterMuzzle
	_velocity = skillDirection * speed
	rotate(skillDirection.angle())
	_shooter = shooter
	connect("body_entered", self, "_on_body_entered")

func _physics_process(delta : float) -> void:
	global_position += _velocity * delta

func _on_body_entered(target) -> void:
	if target == _shooter:
		return
	if target.get_collision_layer() == Rules.LAYER.ACTOR:
		Rules.applyDamage(_shooter, target, damage)
	queue_free()
