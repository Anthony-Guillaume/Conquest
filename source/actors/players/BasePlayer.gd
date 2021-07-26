extends Actor

class_name BasePlayer

signal stateChanged(newState)

var inputRunDirection : Vector2 = Vector2.ZERO

enum STATE {RUNNING, STANDING, DASHING} 
var state = STATE.STANDING

onready var hud : HUD = $CanvasLayer/HUD
onready var camera : Camera2D = $Camera2D

#####################################################
# INITIALISATION
#####################################################

func _ready() -> void:
	skillSet = FireSkillSet.new(self)
	add_child(skillSet)
	hud.initialize(stats.health, skillSet, statusEffectManager)
	animator.setup(self)

func show() -> void:
	.show()
	hud.show()
	if skillSet != null:
		for child in skillSet.get_children():
			if child.has_method("show"):
				child.show()

func hide() -> void:
	.hide()
	hud.hide()
	if skillSet != null:
		for child in skillSet.get_children():
			if child.has_method("hide"):
				child.hide()

func get_class() -> String:
	 return "BasePlayer"

#####################################################
# UPDATE DATA
#####################################################

func _physics_process(delta : float) -> void:
	updateState()
	updateDirection()
	move_and_slide(velocity)

func updateDirection() -> void:
	var newFacingDirection : Vector2 = (get_global_mouse_position() - global_position).normalized()
	facingDirection = newFacingDirection
	emit_signal("faceDirectionChanged", facingDirection)

#####################################################
# STATE MACHINE INPUT
#####################################################

func updateState() -> void:
	match state:
		STATE.STANDING:
			standingInput()
		STATE.RUNNING:
			runningInput()
		STATE.DASHING:
			dashingInput()

func changeStateTo(newState) -> void:
	state = newState
	emit_signal("stateChanged", state)

func startDash() -> void:
	changeStateTo(STATE.DASHING)

func endDash() -> void:
	changeStateTo(STATE.STANDING)

func runningInput() -> void:
	run()
	dash()
	checkCapacitiesInput()
	if velocity.length() == 0:
		changeStateTo(STATE.STANDING)

func standingInput() -> void:
	run()
	checkCapacitiesInput()
	if velocity.length() != 0:
		changeStateTo(STATE.RUNNING)

func dashingInput() -> void:
	checkCapacitiesInput()

#####################################################
# ACTIONS
#####################################################

func run() -> void:
	inputRunDirection.x = int(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	inputRunDirection.y = int(Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	var velocityGain : Vector2 = inputRunDirection * stats.runSpeed.getValue() - velocity
	velocity.x += clamp(velocityGain.x, -runAcceleration, runAcceleration)
	velocity.y += clamp(velocityGain.y, -runAcceleration, runAcceleration)
	velocity = velocity.clamped(stats.runSpeed.getValue())

func checkCapacitiesInput() -> void:
	shootFireNova()
	shootFireCrush()
	shootFireball()

func shootFireball() -> void:
	if Input.is_action_pressed("skill1"):
		skillSet.activate(skillSet.skills.keys()[0])

func shootFireCrush() -> void:
	if Input.is_action_just_pressed("skill2"):
		skillSet.activate(skillSet.skills.keys()[1])

func shootFireNova() -> void:
	if Input.is_action_just_pressed("skill3"):
		skillSet.activate(skillSet.skills.keys()[2])

func dash() -> void:
	if Input.is_action_pressed("skill4"):
		skillSet.activate(skillSet.skills.keys()[3])
