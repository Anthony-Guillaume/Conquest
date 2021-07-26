extends BaseAi

class_name AggressiveBoss

var dashing : bool = false

func _ready() -> void:
	skillSet = FireSkillSet.new(self)
	add_child(skillSet)

func get_class() -> String:
	 return "AggressiveBoss"

func task_attack_while_evading(task):
	evadeAttack()
	task.succeed()

func task_evade(task):
	velocity = player.global_position.direction_to(global_position)
	dash()
	task.succeed()

func task_check_if_self_is_dashing(task):
	if dashing:
		task.succeed()
	else:
		task.failed()

func shoot() -> void:
	facingDirection = global_position.direction_to(player.global_position)
	skillSet.activate("Fireball")

func evadeAttack() -> void:
	facingDirection = global_position.direction_to(player.global_position)
	skillSet.forceActivate("FireNova")

func dash() -> void:
	skillSet.activate("Charge")

func computeRandomDestination() -> Vector2:
	return Algorithm.computeRandomPointInDisk(global_position, 100.0, 300.0, 0, 2*PI)

func startDash() -> void:
	dashing = true

func endDash() -> void:
	dashing = false
