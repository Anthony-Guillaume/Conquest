extends Node2D

class_name DoorAndKey

var keyIsLooted : bool = false

func _ready() -> void:
	$Door.connect("player_at_door", self, "_on_player_at_door")
	$Key.connect("looted", self, "_on_key_looted")

func _on_key_looted() -> void:
	keyIsLooted = true

func _on_player_at_door() -> void:
	if keyIsLooted:
		$Door.open()
