extends Node2D

class_name Split

var _shooter = null
var numberOfDuplicated : int = 1

func get_class() -> String:
	return "Split"

func _ready() -> void:
	split()

func setup(shooter, globalPosition : Vector2, skillDirection : Vector2, shooterMuzzle : float) -> void:
	global_position = globalPosition
	_shooter = shooter

func split() -> void:
	var game : Node2D = get_tree().get_root().get_node("Game")
	for i in numberOfDuplicated:
		game.addAi(_shooter)
	queue_free()
