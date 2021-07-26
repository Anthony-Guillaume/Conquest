extends Actor

class_name BaseAi

export var meleeReach : float = 450.0
export var sightDistance : float = 1000.0
var securityDistance : float = 80.0

var player = null
var distanceToRefreshPath : float = 75.0
var pathDestination : Vector2 = Vector2.ZERO
var navigation : Navigation2D = null
var _path : PoolVector2Array = PoolVector2Array()
var minimalStepDistance : float = 30.0
onready var _logicTree = $LogicTree

func _ready() -> void:
	deactivateLogicTree()

func activateLogicTree() -> void:
	_logicTree.set_process(true)
	_logicTree.set_physics_process(true)

func deactivateLogicTree() -> void:
	_logicTree.set_process(false)
	_logicTree.set_physics_process(false)

func setup(player, navigation : Navigation2D) -> void:
	self.player = player
	self.navigation = navigation

func setupOnPlayerReady() -> void:
	pass

func get_class() -> String:
	 return "AI"

func _physics_process(delta : float) -> void:
	move_and_slide(velocity)

func applyStatusEffect(effect : StatusEffect) -> void:
	statusEffectManager.apply(effect)

################################################################################
# BASIC TASKS
################################################################################

func task_check_if_player_is_too_close(task):
	if isPlayerTooClose():
		task.succeed()
	else:
		task.failed()

func task_check_if_player_is_within_melee_reach(task):
	if isPlayerWithinMeleeReach():
		task.succeed()
	else:
		task.failed()

func task_check_if_player_is_in_sight(task):
	if isPlayerIsInSight():
		task.succeed()
	else:
		task.failed()

func task_move_toward_player(task):
	if pathDestination.distance_to(player.global_position) > distanceToRefreshPath:
		computePathTo(player.global_position)
	moveTo(player.global_position)
	task.succeed()

func task_move_toward_random_destination(task):
	moveTo(computeRandomDestination())
	task.succeed()

func task_shoot_at_player(task):
	shoot()
	task.succeed()

func task_check_if_player_is_in_sight_distance(task):
	if isPlayerInSightDistance():
		task.succeed()
	else:
		task.failed()

################################################################################
# ACTIONS
################################################################################

func isPlayerIsInSight() -> bool:
	var spaceState : Physics2DDirectSpaceState = get_world_2d().get_direct_space_state()
	var collisionMaskWorldAndActors : int = 3
	var collisionResult : Dictionary = spaceState.intersect_ray(global_position, player.global_position, [self], collisionMaskWorldAndActors)
	if collisionResult.collider != player:
		return false
	return isPlayerInSightDistance()

func isPlayerInSightDistance() -> bool:
	return player.global_position.distance_to(global_position) < sightDistance

func isPlayerTooClose() -> bool:
	return player.global_position.distance_to(global_position) < securityDistance

func isPlayerWithinMeleeReach() -> bool:
	return player.global_position.distance_to(global_position) < meleeReach

func moveTo(destination : Vector2) -> void:
	if _path.empty():
		computePathTo(destination)
	if not _path.empty():
		followPath()

func computePathTo(destination : Vector2) -> void:
	_path = navigation.get_simple_path(global_position, destination, false)
	pathDestination = destination

func followPath() -> void:
	var vectorToNextPoint : Vector2 = _path[0] - global_position
	velocity = vectorToNextPoint.normalized() * stats.runSpeed.getBaseValue()
	if vectorToNextPoint.length() < minimalStepDistance:
		_path.remove(0)

func shoot() -> void:
	pass

func computeRandomDestination() -> Vector2: # virtual
	return Vector2.ZERO
