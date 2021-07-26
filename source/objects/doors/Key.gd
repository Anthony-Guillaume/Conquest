extends Area2D

class_name Key

signal looted

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(actor) -> void:
	if actor.get_class() == "BasePlayer":
		emit_signal("looted")
		queue_free()
