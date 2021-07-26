extends Area2D

class_name Stair

signal player_on_stair(player)

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body) -> void:
	if body.get_class() == "BasePlayer":
		emit_signal("player_on_stair", body)
