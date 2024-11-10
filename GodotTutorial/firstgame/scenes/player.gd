extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if velocity.x != 0:
		if velocity.x > 0:
			animated_sprite.flip_h = false 
			if not animated_sprite.is_playing() or animated_sprite.animation !="Run":
				animated_sprite.play("Run")
		elif velocity.x < 0:
			animated_sprite.flip_h = true 
			if not animated_sprite.is_playing() or animated_sprite.animation != "Run":
				animated_sprite.play("Run")
	else:
		if not animated_sprite.is_playing() or animated_sprite.animation != "idle":
			animated_sprite.play("idle")
