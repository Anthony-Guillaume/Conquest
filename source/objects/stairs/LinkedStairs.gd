extends Node2D

class_name LinkedStairs

onready var stair1 : Stair = $Stair1
onready var stair2 : Stair = $Stair2
var canTakeStairs : bool = true
var durationToTakeStairsAgain : float = 1.5

func _ready() -> void:
	stair1.connect("player_on_stair", self, "_on_player_on_stair", [stair1])
	stair2.connect("player_on_stair", self, "_on_player_on_stair", [stair2])

func _on_player_on_stair(player, stair) -> void:
	if not canTakeStairs:
		return
	canTakeStairs = false
	$SceneTransitor.transit()
	if stair == stair1:
		player.global_position = stair2.global_position
	else:
		player.global_position = stair1.global_position
	yield(get_tree().create_timer(durationToTakeStairsAgain, false), "timeout")
	canTakeStairs = true
