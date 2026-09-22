extends CharacterBody2D


const SPEED = 800.0
const JUMP_VELOCITY = -1100.0
## Velocity applied on the second (mid-air) jump. Slightly weaker than the first.
const DOUBLE_JUMP_VELOCITY = -900.0
## Total jumps allowed before touching the floor again (2 = double jump).
const MAX_JUMPS = 2

var jumps_left := MAX_JUMPS


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Landed: refill jumps.
		jumps_left = MAX_JUMPS

	# Handle jump / double jump.
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			velocity.y = DOUBLE_JUMP_VELOCITY
		jumps_left -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
