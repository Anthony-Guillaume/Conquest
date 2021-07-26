extends Node

class_name StatusEffectManager

signal effectAdded(effect)
signal effectRemoved(effect)

var _target = null

var _burning : Node = Node.new()
var _frozen : Node = Node.new()
var _immunity : Node = Node.new()
var _curseOfWeakness : Node = Node.new()
var _stealth : Node = Node.new()

func _ready() -> void:
	_burning.name = "BurningEffect"
	_frozen.name = "FrozenEffect"
	_immunity.name = "ImmunityEffect"
	_curseOfWeakness.name = "CurseOfWeakness"
	_stealth.name = "StealthEffect"
	add_child(_burning)
	add_child(_frozen)
	add_child(_immunity)
	add_child(_curseOfWeakness)
	add_child(_stealth)

func get_class() -> String:
	 return "StatusEffectManager"

func setup(target) -> void:
	_target = target

func apply(effect : StatusEffect) -> void:
	if _canEffectBeAppliable(effect):
		effect.connect("tree_exiting", self, "_on_effect_exiting", [effect])
		get_node(effect.get_class()).add_child(effect)
		emit_signal("effectAdded", effect)

func _on_effect_exiting(effect : StatusEffect) -> void:
	effect.reverse()
	emit_signal("effectRemoved", effect)

func _canEffectBeAppliable(effect : StatusEffect) -> bool:
	return get_node(effect.get_class()).get_child_count() < effect.maxStack
