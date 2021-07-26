extends Resource

class_name ActorStatistics

var health : Attribute
var runSpeed : Attribute
var power : Attribute

var immune : bool = false

func _init(health : Attribute, runSpeed : Attribute, power : Attribute) -> void:
	self.health = health
	self.runSpeed = runSpeed
	self.power = power

func addHealth(modifier : AttributeModifier) -> void:
	health.add(modifier)

func removeHealth(modifier : AttributeModifier) -> void:
	health.remove(modifier)

func addRunSpeed(modifier : AttributeModifier) -> void:
	runSpeed.add(modifier)

func removeRunSpeed(modifier : AttributeModifier) -> void:
	runSpeed.remove(modifier)

func addPower(modifier : AttributeModifier) -> void:
	if immune:
		return
	power.add(modifier)

func removePower(modifier : AttributeModifier) -> void:
	power.remove(modifier)

func addImmunity() -> void:
	immune = true

func removeImmunity() -> void:
	immune = false
