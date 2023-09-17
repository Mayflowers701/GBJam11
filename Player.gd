extends CharacterBody2D

# Player Properties
const SPEED = 60.0
const JUMP_VELOCITY = -120.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 400#ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 1;
var facing = 1;
var lightSpeed = 0.2

func _ready():
	#$ShadowOverlay.hide()
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
	# Also update sprite direction
	if(direction < 0):
		facing = -1
		$AnimatedSprite2D.flip_h = true
		$ShadowOverlay.flip_h = true
	elif(direction > 0):
		facing = 1
		$AnimatedSprite2D.flip_h = false
		$ShadowOverlay.flip_h = false
		
	#Update Light Direction (see DynamicLight for effects)
	if(Input.is_action_pressed("game_up")):
		$ShadowOverlay.rotation = lerp($ShadowOverlay.rotation, 0.785398*-sign(facing), lightSpeed)
		$AnimatedSprite2D.animation = "look"
		$AnimatedSprite2D.frame = 1
	elif(Input.is_action_pressed("game_down")):
		$ShadowOverlay.rotation = lerp($ShadowOverlay.rotation, 0.785398*sign(facing), lightSpeed)
		$AnimatedSprite2D.animation = "look"
		$AnimatedSprite2D.frame = 2
	else:
		$ShadowOverlay.rotation = lerp($ShadowOverlay.rotation, 0.0, lightSpeed)
		$AnimatedSprite2D.frame = 0
	
	if direction:
		$AnimatedSprite2D.animation = "walk"
	
