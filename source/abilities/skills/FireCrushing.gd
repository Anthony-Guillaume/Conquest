extends Node2D

class_name FireCrushing

var damagePerCrush : float = 60.0
var rotateSpeed : float = 4.1
var _shooter = null
var numberOfHit : int = 0
var numberOfCrush : int = 2
var reach : float = 300.0

var destination : Vector2
var center : Vector2
var angle : float
var radius : float

func setup(shooter, globalPosition : Vector2, skillDirection : Vector2, shooterMuzzle : float) -> void:
	_shooter = shooter
	global_position = globalPosition
	destination  = _shooter.get_global_mouse_position()
	destination = skillDirection * reach + position
	center  = (destination + globalPosition) * 0.5
	angle  = (globalPosition - center).angle()
	radius  = (destination - globalPosition).length() * 0.5
	$UnclockwiseCrush.setup(shooter, rotateSpeed, radius, angle, center, false)
	$UnclockwiseCrush.connect("hit", self, "_on_crush_hit")
	$ClockwiseCrush.setup(shooter, rotateSpeed, radius, angle, center, true)
	$ClockwiseCrush.connect("hit", self, "_on_crush_hit")
	$UnclockwiseCrush.damage = damagePerCrush
	$ClockwiseCrush.damage = damagePerCrush
	$AudioStreamPlayer2D.play()

func _on_crush_hit() -> void:
	numberOfHit += 1
	if numberOfHit == numberOfCrush:
		queue_free()
