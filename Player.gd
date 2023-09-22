extends CharacterBody2D

# Player Properties
const SPEED = 60.0
const JUMP_VELOCITY = -120.0
const WALL_JUMP_VELOCITY = -100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 400#ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 1;
var vDir = 0;
var facing = 1;
var lightSpeed = 0.2

var isClimb = false
var climbSpeed = 40

var wallJumping = false
var wallJumpTimerInit = 7
var wallJumpTimer = 0

var jumpsInit = 1
var jumps = jumpsInit

var coyoteTimeInit = 10
var coyoteTime = coyoteTimeInit

var doubleTapInit = 15
var doubleTap = 0

var sprint = false
var canSprint = true


func _ready():
	#ShadowOverlay.show()
	pass

func _physics_process(delta):
	

	
	# Also update sprite direction
	if !isClimb:
		if(direction < 0):
			facing = -1
			$AnimatedSprite2D.flip_h = true
			$ShadowOverlay.flip_h = true
		elif(direction > 0):
			facing = 1
			$AnimatedSprite2D.flip_h = false
			$ShadowOverlay.flip_h = false
		
	# Get the input direction and handle the movement/deceleration.
	if !wallJumping && !isClimb:
		direction = Input.get_axis("game_left", "game_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			sprint = false
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	
	# Sprint Check
	# first tap check
	if Input.is_action_just_pressed("game_left"):
		# second tap check
		if Input.is_action_just_pressed("game_left") && doubleTap > 0:
			sprint = true
		doubleTap = doubleTapInit
	# first tap check
	if Input.is_action_just_pressed("game_right"):
		# second tap check
		if Input.is_action_just_pressed("game_right") && doubleTap > 0:
			sprint = true
		doubleTap = doubleTapInit
		
	if sprint && canSprint:
		velocity.x = direction * SPEED * 1.5
		$Trail.emitting = true
	else:
		$Trail.emitting = false
	
	if doubleTap > 0:
		doubleTap -= 1
	
	# Climb check
	if Input.is_action_pressed("game_x") and is_on_wall() and !wallJumping:
		isClimb = true
		sprint = false
		vDir = Input.get_axis("game_up", "game_down")
		if vDir:
			velocity.y = vDir * climbSpeed
		else:
			velocity.y = move_toward(velocity.y, 0, climbSpeed)
	else:
		isClimb = false
	
	
	# Add the gravity.
	if not is_on_floor() && not isClimb:
		velocity.y += gravity * delta
		

	# Coyote Time
	if coyoteTime && !is_on_floor():
		coyoteTime-=1
	if is_on_floor():
		coyoteTime = coyoteTimeInit
		jumps = jumpsInit
		#WALL_JUMP_VELOCITY = -100

	# Handle Jump.
	if Input.is_action_just_pressed("game_z") and jumps and coyoteTime > 0:
		velocity.y = JUMP_VELOCITY
		jumps-=1
		
	# Wall Jump
	if is_on_wall() and !is_on_floor() and Input.is_action_just_pressed("game_z"):
		wallJumping = true
		isClimb = false
		sprint = false
		wallJumpTimer = wallJumpTimerInit
		#direction *= -1
		
		velocity.y = WALL_JUMP_VELOCITY
		#WALL_JUMP_VELOCITY += 10
		velocity.x = -facing * SPEED *2
	
	# Reset Wall Jump
	if wallJumping:
		wallJumpTimer-=1
		if wallJumpTimer <= 0:
			wallJumping = false



	move_and_slide()
	
	# Handling other things
	
	# Have Camera lead a little ahead of player's facing

		
		
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
		#$AnimatedSprite2D.animation = "walk"
		pass
	
