extends StatusEffect

class_name ImmunityEffect

func _init(target, periodDuration : float):
	maxStack = 1
	_target = target
	_numberOfPeriod = 0
	_periodDuration = periodDuration

func get_class() -> String:
	 return "ImmunityEffect"

func apply() -> void:
	_target.stats.addImmunity()

func reverse() -> void:
	_target.stats.removeImmunity()
