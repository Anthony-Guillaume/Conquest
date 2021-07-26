extends StaticBody2D

class_name Door

signal player_at_door

func _ready() -> void:
	$Area2D.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(actor) -> void:
	if actor.get_class() == "BasePlayer":
		emit_signal("player_at_door")

func open() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$AudioStreamPlayer2D.play()

func close() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	$AudioStreamPlayer2D.play()
