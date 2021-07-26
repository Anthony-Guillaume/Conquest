extends Node2D

class_name Spawner

onready var _timer : Timer = $Timer
var _aiToSpawnPath : String
var _game : Node = null
var _period : float

func setup(game : Node, aiToSpawnPath : String, period : float, delay : float) -> void:
	_game = game
	_aiToSpawnPath = aiToSpawnPath
	_period = period
	_timer.set_wait_time(_period)
	_timer.connect("timeout", self, "_on_timer_timeout")
	yield(get_tree().create_timer(delay), "timeout")
	_timer.start()

func _on_timer_timeout() -> void:
	_spawn()

func _spawn() -> void:
	_game.createAi(_aiToSpawnPath, global_position)
