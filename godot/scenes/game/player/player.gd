extends CharacterBody2D

@onready var rotating_part = $PlayerRotatingPart

@export var max_speed: float = 200.0
@export var acceleration: float = 1000.0
@export var idle_decceleration: float = 300.0

func _process(_delta):
	if Input.is_action_just_pressed("rotate_clockwise"):
		rotating_part.start_clockwise_rotation()
	if Input.is_action_just_pressed("rotate_counterclockwise"):
		rotating_part.start_counterclockwise_rotation()


func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction != Vector2.ZERO:
		velocity += input_direction * acceleration * delta
		velocity = velocity.limit_length(max_speed)
	else:
		# deccelerate if no input
		if velocity.length() > idle_decceleration * delta:
			velocity -= velocity.normalized() * idle_decceleration * delta
		else:
			# snap to 0 when velocity is very low
			velocity = Vector2.ZERO
	move_and_slide()
