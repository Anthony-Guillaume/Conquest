extends Node

class_name StatusEffect

var maxStack : int
var _target
var _numberOfPeriod : int
var _periodDuration : float
var _currentPeriod : int = 0
var _timer : Timer = Timer.new()

func get_class() -> String:
	 return "StatusEffect"

func _ready() -> void:
	_timer.connect("timeout", self, "_on_timer_timeout")
	add_child(_timer)
	_timer.start(_periodDuration)
	apply()

func _on_timer_timeout() -> void:
	if _currentPeriod == _numberOfPeriod:
		queue_free()
		return
	_currentPeriod += 1
	apply()

func apply() -> void:
	pass

func reverse() -> void:
	pass
