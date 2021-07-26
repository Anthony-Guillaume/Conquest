extends BaseAi

class_name Kamikaze

var exploded : bool = false

func _ready() -> void:
	meleeReach = 40
	skillSet = SkillSet.new(self)
	skillSet.create("SuicideExplosion", 1)
	add_child(skillSet)

func get_class() -> String:
	 return "Kamikaze"

func task_check_if_self_explode(task):
	if exploded:
		task.succeed()
	else:
		task.failed()

func shoot() -> void:
	facingDirection = global_position.direction_to(player.global_position)
	skillSet.activate("SuicideExplosion")
	exploded = true
	velocity = Vector2.ZERO
	sprite.hide()
