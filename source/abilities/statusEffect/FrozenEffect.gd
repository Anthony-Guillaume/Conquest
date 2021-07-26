extends StatusEffect

class_name FrozenEffect

var _slowCoefficient : float
var _attributeModifier : AttributeModifier

func _init(target, periodDuration : float, slowCoefficient : float):
	maxStack = 1
	_target = target
	_numberOfPeriod = 0
	_periodDuration = periodDuration
	_slowCoefficient = slowCoefficient
	_attributeModifier = AttributeModifier.new(0, -_slowCoefficient)

func get_class() -> String:
	 return "FrozenEffect"

func apply() -> void:
	_target.stats.addRunSpeed(_attributeModifier)

func reverse() -> void:
	_target.stats.removeRunSpeed(_attributeModifier)
