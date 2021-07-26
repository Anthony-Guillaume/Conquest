extends StatusEffect

class_name CurseOfWeakness

var _powerCoefficient : float
var _attributeModifier : AttributeModifier

func _init(target, periodDuration : float, coefficient : float):
	maxStack = 1
	_target = target
	_numberOfPeriod = 0
	_periodDuration = periodDuration
	_powerCoefficient = coefficient
	_attributeModifier = AttributeModifier.new(0, -_powerCoefficient)

func get_class() -> String:
	 return "CurseOfWeakness"

func apply() -> void:
	_target.stats.addPower(_attributeModifier)

func reverse() -> void:
	_target.stats.removePower(_attributeModifier)
