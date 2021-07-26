extends Node2D

class_name PortalTwoWay

var _playersRecentlyEntered : Array = []
var _durationToBeAbleToReEnterInPortal : float = 1.5

func _ready() -> void:
	$Portal1.connect("body_entered", self, "_teleport_player_to_destination1")
	$Portal2.connect("body_entered", self, "_teleport_player_to_destination2")

func _teleport_player_to_destination1(player) -> void:
	if _playersRecentlyEntered.has(player):
		return
	$AudioStreamPlayer2D.play()
	player.global_position = $Portal2.global_position
	_playersRecentlyEntered.push_back(player)
	_preventPlayerToEnterInPortal(player)

func _teleport_player_to_destination2(player) -> void:
	if _playersRecentlyEntered.has(player):
		return
	$AudioStreamPlayer2D.play()
	player.global_position = $Portal1.global_position
	_playersRecentlyEntered.push_back(player)
	_preventPlayerToEnterInPortal(player)

func _preventPlayerToEnterInPortal(player) -> void:
	yield(get_tree().create_timer(_durationToBeAbleToReEnterInPortal), "timeout")
	_playersRecentlyEntered.erase(player)
