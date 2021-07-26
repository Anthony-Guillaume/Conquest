extends BaseLevel

func handlePlayerDeath() -> void:
	handleDefeat()

func handleAiDeath(ai : BaseAi) -> void:
	killAi(ai)
	if deadAisCount == _ais.size():
		handleVictory()
