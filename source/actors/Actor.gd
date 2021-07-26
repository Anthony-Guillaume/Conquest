extends KinematicBody2D

class_name Actor

signal death()
signal faceDirectionChanged(direction)

var wallFriction : float = 0.05
var muzzle : float = 60.0

var stats : ActorStatistics
var velocity : Vector2  = Vector2.ZERO
var facingDirection : Vector2  = Vector2.ZERO
var runAcceleration : float = 40

var statusEffectManager : StatusEffectManager = StatusEffectManager.new()
var statusEffectAnimationManager : StatusEffectAnimationManager = preload("res://source/abilities/statusEffect/StatusEffectAnimationManager.tscn").instance()
var skillSet : SkillSet
var animator : Animator = Animator.new()

onready var sprite : Sprite = $Sprite
onready var collisionShape : CollisionShape2D = $CollisionShape2D

# EXPORT ACTOR STATS : Temporaire, godot 4.0 permettra d'exporter des resources personalisées
export var baseHealth : float = 100
export var maxHealth : float = 200
export var baseSpeed : float = 280
export var maxSpeed : float = 500
# EXPORT ACTOR STATS

func _ready() -> void:
	statusEffectManager.setup(self)
	add_child(statusEffectManager)
	statusEffectAnimationManager.setup(statusEffectManager, sprite)
	add_child(statusEffectAnimationManager)
	move_child(statusEffectAnimationManager, 0)
	add_child(animator)
	initializeStats()

func initializeStats() -> void:
	var health : Attribute = Attribute.new(baseHealth, 0, maxHealth)
	var runspeed : Attribute = Attribute.new(baseSpeed, 0, maxSpeed)
	var power : Attribute = Attribute.new(0, 0, 0)
	stats = ActorStatistics.new(health, runspeed, power)
	stats.health.connect("valueChanged", self, "_on_health_changed")

func _on_health_changed(health : float) -> void:
	if health < 0.1:
		emit_signal("death")

func applyStatusEffect(effect : StatusEffect) -> void:
	statusEffectManager.apply(effect)
