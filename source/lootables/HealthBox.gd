extends Area2D

class_name HealthBox

export var health : int = 50
export var coolDown : float = 25.0
export var oneShot : bool = false
var modifier : AttributeModifier
onready var sfx : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	modifier = AttributeModifier.new(health, 0)
	sfx.connect("finished", self, "_on_sfx_finished")

func _on_sfx_finished() -> void:
	if oneShot:
		queue_free()

func _on_body_entered(body) -> void:
	sfx.play()
	body.stats.addHealth(modifier)
	hide()
	if oneShot:
		return
	set_deferred("monitoring", false)
	yield(get_tree().create_timer(coolDown), "timeout")
	set_deferred("monitoring", true)
	show()
