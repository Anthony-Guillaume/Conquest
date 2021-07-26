extends Area2D

class_name VaporBlast

var damagePeriodic : float = 10.0
var damageOnBlast : float = 50.0
var period : float = 0.4
var numberOfPeriod : int = 3
var currentPeriod : int = 0

var _shooter = null
onready var _timer : Timer = $Timer
onready var animation : SkillAnimation = $Sprite

func _ready() -> void:
	_timer.connect("timeout", self, "_on_timeout")
	_timer.start(period)
	animation.setLenght(period)
	applyPeriodicDamage()
	
func setup(shooter, globalPosition : Vector2, skillDirection : Vector2, shooterMuzzle : float) -> void:
	global_position = globalPosition
	_shooter = shooter

func _on_timeout() -> void:
	if currentPeriod == numberOfPeriod:
		explode()
	else:
		applyPeriodicDamage()
		currentPeriod += 1
		_timer.start(period)

func applyPeriodicDamage() -> void:
	animation.play()
	damageBodyInArea(damagePeriodic)

func explode() -> void:
	damageBodyInArea(damageOnBlast)
	queue_free()

func damageBodyInArea(damage : float) -> void:
	for target in get_overlapping_bodies():
		Rules.applyDamage(_shooter, target, damage)
