extends Sprite2D

var target_rotation: float = 0.0
const ROTATION_EPSILON: float = 0.01
@export var rotation_speed_degrees_per_second: float = 720.0

func _ready() -> void:
	target_rotation = rotation

func start_clockwise_rotation() -> void:
	target_rotation += deg_to_rad(90)
	target_rotation = fmod(target_rotation, PI * 2)

func start_counterclockwise_rotation() -> void:
	target_rotation -= deg_to_rad(90)
	target_rotation = fmod(target_rotation, PI * 2)

func _process(delta) -> void:
	if abs(rotation - target_rotation) > ROTATION_EPSILON:
		# Calculate the maximum amount we can rotate this frame.
		var rotate_amount_this_frame = deg_to_rad(rotation_speed_degrees_per_second) * delta

		# Determine the shortest path to rotate
		var diff = fmod(target_rotation - rotation, PI * 2)
		if diff > PI:
			diff -= PI * 2
		elif diff < -PI:
			diff += PI * 2

		# Apply rotation gradually
		if abs(diff) < rotate_amount_this_frame:
			rotation = target_rotation # Snap to target if very close
		else:
			rotation += sign(diff) * rotate_amount_this_frame
	else:
		# If we're very close to the target, snap exactly to it to avoid tiny oscillations.
		# This also ensures rotation becomes exactly 0, 90, 180 etc.
		rotation = target_rotation
