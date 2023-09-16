extends CharacterBody2D

# Player Properties
const SPEED = 60.0
const JUMP_VELOCITY = -120.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 400#ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 1;
var facing = 1;

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("game_z") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("game_left", "game_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Handling other things
	
	# Have Camera lead a little ahead of player's facing
	if(direction < 0):
		facing = -1
	elif(direction > 0):
		facing = 1
	
