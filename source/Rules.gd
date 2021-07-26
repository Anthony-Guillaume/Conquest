extends Node

const DELTA : float = 1.0 / 60.0 # actuellement
const GRAVITY : float = 600.0
const FORCE_UNIT : float = GRAVITY
const DISTANCE_UNIT : float = 64.0 # tile size
const SPEED_UNIT : float = DISTANCE_UNIT * DELTA

const FLOOR_NORMAL : Vector2 = Vector2(0, -1)
const SNAP : Vector2 = Vector2(0, 10)

enum LAYER {WORLD = 1, ACTOR = 2, PROJECTILE = 4, LOOTABLE = 8, WATER = 32}

func applyDamageFromExplosion(shooter, target, damage : float, explosionCenter : Vector2, explosionRadius : float) -> void:
	var distanceExplosionCenterToTarget : float = explosionCenter.distance_to(target.global_position)
	damage = damage * (1 - distanceExplosionCenterToTarget / explosionRadius)
	applyDamage(shooter, target, damage)

func applyDamage(shooter, target, damage : float) -> void:
	if shooter == target:
		damage *= 0.5
	var modifier : AttributeModifier = AttributeModifier.new(-damage, 0)
	target.stats.addHealth(modifier)

func applyHealth(shooter, target, health : float) -> void:
	var modifier : AttributeModifier = AttributeModifier.new(health, 0)
	target.stats.addHealth(modifier)

func applyBurning(shooter, target, numberOfPeriod : int, periodDuration : float, damage : float) -> void:
	var burningEffect : BurningEffect = BurningEffect.new(target, numberOfPeriod, periodDuration, damage)
	_applyStatusEffect(target, burningEffect)

func applyFrozen(shooter, target, periodDuration : float, slowPercentage : float) -> void:
	var frozenEffect : FrozenEffect = FrozenEffect.new(target, periodDuration, slowPercentage)
	_applyStatusEffect(target, frozenEffect)

func applyImmunity(shooter, target, periodDuration : float) -> void:
	var immunityEffect : ImmunityEffect = ImmunityEffect.new(target, periodDuration)
	_applyStatusEffect(target, immunityEffect)

func applyCurseOfWeakness(shooter, target, periodDuration : float, powerCoefficient : float) -> void:
	var curseOfWeakness : CurseOfWeakness = CurseOfWeakness.new(target, periodDuration, powerCoefficient)
	_applyStatusEffect(target, curseOfWeakness)

func applyStealth(shooter, target, periodDuration : float) -> void:
	var stealthEffect : StealthEffect = StealthEffect.new(target, periodDuration)
	_applyStatusEffect(target, stealthEffect)

func _applyStatusEffect(target, effect : StatusEffect) -> void:
	target.applyStatusEffect(effect)
