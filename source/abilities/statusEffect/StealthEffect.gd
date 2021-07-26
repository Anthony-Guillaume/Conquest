extends StatusEffect

class_name StealthEffect

func _init(target, periodDuration : float):
	maxStack = 1
	_target = target
	_numberOfPeriod = 0
	_periodDuration = periodDuration

func get_class() -> String:
	 return "StealthEffect"

func apply() -> void:
#	_target.stealth()
	pass

func reverse() -> void:
#	_target.stopStealth()
	pass
