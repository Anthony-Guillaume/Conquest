extends Area2D

class_name Charge

var damage : float = 20.0
var _shooter = null
var speed : float = 800.0
var duration : float = 0.2
var pushForce : float = 250.0
var targets : Array = Array()

func _ready() -> void:
	$Timer.connect("timeout", self, "_on_timer_timeout")
	$Timer.set_wait_time(duration)
	$Timer.start()
	connect("body_entered", self, "_on_body_entered")
	_shooter.velocity = _shooter.velocity.normalized() * speed
	_shooter.startDash()

func setup(shooter, globalPosition : Vector2, skillDirection : Vector2, shooterMuzzle : float) -> void:
	_shooter = shooter
	global_position = globalPosition
	$CollisionShape2D.shape.radius = shooterMuzzle

func _on_timer_timeout() -> void:
	_shooter.velocity = Vector2.ZERO
	_shooter.endDash()
	queue_free()

func _physics_process(delta : float) -> void:
	global_position = _shooter.global_position
	for target in targets:
		pushOut(target)

func _on_body_entered(target) -> void:
	if target == _shooter:
		return
	if targets.has(target):
		return
	targets.push_back(target)
	Rules.applyDamage(_shooter, target, damage)

func pushOut(target) -> void:
	target.move_and_slide(_shooter.global_position.direction_to(target.global_position) * pushForce)
