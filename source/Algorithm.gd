extends Node2D

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func computeRandomPointInDisk(center : Vector2, minRadius : float, maxRadius : float,  minAngle : float, maxAngle : float) -> Vector2:
	var randomRadius : float = rng.randf_range(minRadius, maxRadius)
	var randomAngle : float = rng.randf_range(minAngle, maxAngle)
	return randomRadius * Vector2(cos(randomAngle), sin(randomAngle)) + center

func computeRadiusOfSmallestCircleShape(shape : Shape2D) -> float:
	match shape.get_class():
		"CircleShape2D":
			return shape.radius
		"RectangleShape2D":
			var size : Vector2 = shape.get_extents()
			return max(size.x, size.y)
		_:
			print("Add others useful shape2D handler")
			assert(false)
	return 0.0

func doesRayCastFirstHitTarget(rayOrigin : Vector2, shooter : Actor, target : Actor) -> bool:
	var spaceState : Physics2DDirectSpaceState = get_world_2d().get_direct_space_state()
	var layer : int = Rules.LAYER.WORLD + Rules.LAYER.ACTOR
	var collider = spaceState.intersect_ray(rayOrigin, target.global_position, [shooter], layer).collider
	return collider != null and collider == target
