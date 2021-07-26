extends BaseAi

class_name Boss1

export var positions : Array
var positionIndex : int = 0
onready var timer : Timer = $Timer

func _ready() -> void:
	skillSet = FireSkillSet.new(self)
	skillSet.create("BigFireball", 0)
	add_child(skillSet)
	timer.connect("timeout", self, "_on_timer_timeout")

func get_class() -> String:
	 return "Boss1"

func _on_timer_timeout() -> void:
	teleport()
	shootBigFireball()

func teleport() -> void:
	positionIndex += 1
	if positionIndex >= positions.size():
		positionIndex = 0
	global_position = get_node(positions[positionIndex]).global_position

func shootBigFireball() -> void:
	facingDirection = global_position.direction_to(player.global_position)
	skillSet.forceActivate("BigFireball")

func shoot() -> void:
	facingDirection = global_position.direction_to(player.global_position)
	skillSet.activate("Fireball")
