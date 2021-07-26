extends Area2D

class_name PitTrap

var damage : float = 50.0
var targets : Array = Array()

func _ready() -> void:
	connect("body_entered", self, "on_body_entered")

func on_body_entered(target) -> void:
	if targets.has(target):
		return
	targets.push_back(target)
	Rules.applyDamage(self, target, damage)
