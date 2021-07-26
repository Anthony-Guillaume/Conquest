extends StatusEffect

class_name BurningEffect

var _damage : float

func _init(target, numberOfPeriod : int, periodDuration : float, damage : float):
	maxStack = 3
	_target = target
	_numberOfPeriod = numberOfPeriod
	_periodDuration = periodDuration
	_damage = damage

func get_class() -> String:
	 return "BurningEffect"

func apply() -> void:
	Rules.applyDamage(self, _target, _damage)
