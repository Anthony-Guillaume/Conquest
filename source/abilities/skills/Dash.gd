extends Node

class_name Dash

var _shooter = null
var speed : float = 800.0
var duration : float = 0.2

func _ready() -> void:
	$Timer.connect("timeout", self, "_on_timer_timeout")
	$Timer.set_wait_time(duration)
	$Timer.start()
	_shooter.velocity = _shooter.velocity.normalized() * _shooter.dashSpeed
	_shooter.startDash()

func setup(shooter, globalPosition : Vector2, skillDirection : Vector2, shooterMuzzle : float) -> void:
	_shooter = shooter

func _on_timer_timeout() -> void:
	_shooter.velocity = _shooter.velocity.clamped(_shooter.runSpeed)
	_shooter.endDash()
	queue_free()
