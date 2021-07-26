extends Node2D

class_name DoorAndKillable

export var killablesPath : Array = Array()
var killables : Array = Array()

func _ready() -> void:
	for killablePath in killablesPath:
		killables.push_back(get_node(killablePath))
	for killable in killables:
		killable.connect("death", self, "_on_killable_killed", [killable])

func _on_killable_killed(killable) -> void:
	killables.erase(killable)
	if killables.empty():
		$Door.open()
