extends Area2D

class_name FireArea

var damage : float = 50.0
var expandTime : float = 0.8
var expandRadius : float = 200.0
var length : float = 300.0

var _targets : Array = []
var _shooter = null
onready var areaShape : Shape2D = $CollisionShape2D.shape

func _ready() -> void:
	connect("body_entered", self, "_on_self_body_entered")
#	areaShape.radius = 0
#	selfExpand()

func setup(shooter, globalPosition : Vector2, skillDirection : Vector2, shooterMuzzle : float) -> void:
	_shooter = shooter
	global_position = globalPosition
	$CollisionShape2D.shape.extents = 0.0 # TBD

func selfExpand() -> void:
	while areaShape.radius < expandRadius:
		areaShape.radius += expandRadius * 0.1 / expandTime # linear
		yield(get_tree().create_timer(0.1),"timeout")
	queue_free()

func _on_self_body_entered(target) -> void:
	if target == _shooter:
		return
	if _targets.has(target):
		return
	_targets.push_back(target)
