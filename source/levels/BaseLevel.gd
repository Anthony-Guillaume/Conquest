extends Node2D

class_name BaseLevel

var _player = null
onready var _actors : Node2D = $Actors
var _ais : Array = []
onready var _navigation : Navigation2D = $Navigation2D
onready var sceneTransitor : SceneTransitor = $SceneTransitor

var duration : float = 0
var secretFound : int = 0
var deadAisCount : int = 0
var win : bool = false

func _ready() -> void:
	setupActors()
	setupCamera()
	activateAis()

func _process(delta) -> void:
	duration += delta

func _input(event : InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			showInGameMenu()

func showInGameMenu() -> void:
	SceneManager.changeSceneTo("pauseMenu")

func goToScoreMenu() -> void:
	var data : Dictionary = {
							"win" : win,
							"deadAisCount" : deadAisCount,
							"secretFound" : secretFound,
							"duration" : int(duration)
							}
	SceneManager.changeSceneTo("scoreMenu", data)

func setupCamera() -> void:
	SceneManager.makeCurrentCamera(_player.camera)

func setupActors() -> void:
	for actor in _actors.get_children():
		if actor.get_class() == "BasePlayer":
			setupPlayer(actor)
		else:
			setupAi(actor)

func activateAis() -> void:
	for actor in _actors.get_children():
		if actor.get_class() != "BasePlayer":
			actor.activateLogicTree()

func setupPlayer(player) -> void:
	_player = player
	_player.connect("death", self, "_on_player_death")

func setupAi(ai : BaseAi) -> void:
	ai.setup(_player, _navigation)
	ai.connect("death", self, "_on_ai_death", [ai])
	_ais.push_back(ai)

func addAi(ai : BaseAi) -> void:
	yield(get_tree().create_timer(1), "timeout") # wait if caller is freeing
	var newAi : BaseAi = ai.duplicate()
	newAi.global_position = ai.global_position
	setupAi(newAi)
	_actors.add_child(newAi)

func createAi(aiScenePath : String, globalPosition : Vector2) -> void:
	var newAi : BaseAi = load(aiScenePath).instance()
	newAi.global_position = globalPosition
	setupAi(newAi)
	_actors.add_child(newAi)
	newAi.activateLogicTree()

func killAi(ai : BaseAi) -> void:
#	ai.queue_free()
	ai.call_deferred("queue_free")
	deadAisCount += 1

func _on_player_death() -> void:
	handlePlayerDeath()

func _on_ai_death(ai : BaseAi) -> void:
	handleAiDeath(ai)

func handlePlayerDeath() -> void:
	pass

func handleAiDeath(ai : BaseAi) -> void:
	pass

func handleVictory() -> void:
	win = true
	goToScoreMenu()

func handleDefeat() -> void:
	win = false
	goToScoreMenu()

func hide() -> void:
	.hide()
	_player.hide()

func show() -> void :
	.show()
	_player.show()
