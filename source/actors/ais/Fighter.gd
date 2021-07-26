extends BaseAi

class_name Fighter

func _ready() -> void:
	skillSet = FireSkillSet.new(self)
	add_child(skillSet)

func get_class() -> String:
	 return "Fighter"

func shoot() -> void:
	facingDirection = global_position.direction_to(player.global_position)
	skillSet.activate("Fireball")
