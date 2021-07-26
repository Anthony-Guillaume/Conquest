extends BaseLevel

onready var spawner1 : Spawner = $Spawner
onready var spawner2 : Spawner = $Spawner2
onready var spawner3 : Spawner = $Spawner3
onready var spawner4 : Spawner = $Spawner4
onready var boss : BaseAi = $Actors/Boss1

func _ready() -> void:
	var spawnPeriod : float = 10
	var pathToAi : String = "res://source/actors/ais/Kamikaze.tscn"
	var delay : float = 5
	spawner1.setup(self, pathToAi, spawnPeriod, delay)
	spawner2.setup(self, pathToAi, spawnPeriod, delay * 2)
	spawner3.setup(self, pathToAi, spawnPeriod, delay)
	spawner4.setup(self, pathToAi, spawnPeriod, delay * 2)
	initializeBossHealhBar(boss.stats.health)
#	MusicManager.play("Echo Blue Music - Catch Me If You Dare")

func initializeBossHealhBar(healthAttribute : Attribute) -> void:
	$CanvasLayer/BossHealthBar.initialize(healthAttribute.getMaxValue(), healthAttribute.getValue())
	healthAttribute.connect("valueChanged", $CanvasLayer/BossHealthBar, "updateValue")

func handlePlayerDeath() -> void:
	handleDefeat()

func handleAiDeath(ai : BaseAi) -> void:
	killAi(ai)
	if ai == boss:
		handleVictory()
