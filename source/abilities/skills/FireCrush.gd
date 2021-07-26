extends Area2D

class_name FireCrush

signal hit()

var _shooter
var damage : float = 20.0
var _rotateSpeed : float
var _radius : float
var _angle : float
var _initialAngle : float
var _center : Vector2
var _rotateSense : int
var _angleGained : float = 0
var spriteDirection : Vector2 = Vector2.DOWN
onready var _animation : SkillAnimation = $Sprite

func _ready() -> void:
	_animation.playInLoop()

func setup(shooter, rotateSpeed : float, radius : float, initialAngle : float, center : Vector2, clockwise : bool) -> void:
	_shooter = shooter
	_rotateSpeed = rotateSpeed
	_radius = radius
	_angle = initialAngle
	_initialAngle = initialAngle
	_center = center
	_rotateSense = 1 if clockwise else -1
	connect("body_entered", self, "_on_body_entered")

func _process(_delta : float):
	var newDirection : Vector2 = Vector2(-sin(_angle), cos(_angle)) * _rotateSense
	_animation.rotate(spriteDirection.angle_to(newDirection))
	spriteDirection = newDirection

func _physics_process(delta : float) -> void:
	_angle += _rotateSense * _rotateSpeed * delta
	_angleGained += _rotateSpeed * delta
	if _angleGained > 2 * PI:
		emit_signal("hit")
		queue_free()
		return
	global_position = _center + _radius * Vector2(cos(_angle), sin(_angle))

func _on_body_entered(target) -> void:
	if target == _shooter:
		return
	if target.get_collision_layer() == Rules.LAYER.ACTOR:
		Rules.applyDamage(_shooter, target, damage)
	emit_signal("hit")
	queue_free()
