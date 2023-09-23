extends CharacterBody2D

@export var sleep = true
var wait = 600

@export var width = 8

var movement_speed: float = 40.0
var movement_target_position: Vector2 = Vector2(60.0,180.0)

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player = get_node("/root/World/Player")

var soundlatch = true

var direction = Vector2(0,0)
var mouthTurn = 0.0

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	call_deferred("actor_setup")
	
func _draw():
	#draw_circle(Vector2(0,0), width, Color.hex(0x000000ff))
	
	var A = Vector2(1,0).rotated( direction.angle() + PI/2 ) * width 
	var B = Vector2(1,0).rotated( direction.angle() - PI/2 ) * width
	
	var C = Vector2(1,0).rotated( direction.angle() + mouthTurn) * width * 2
	var D = Vector2(1,0).rotated( direction.angle() + mouthTurn/2) * width * 2
	var E = Vector2(1,0).rotated( direction.angle() - mouthTurn/2) * width * 2
	var F = Vector2(1,0).rotated( direction.angle() - mouthTurn) * width * 2
	
	var polyA = [A,B,C]
	var polyB = [A,B,D]
	var polyC = [A,B,E]
	var polyD = [A,B,F]
	
	var colors = [Color.hex(0x252525ff)]
	
	draw_polygon(polyA, colors)
	#draw_polygon(polyB, colors)
	#draw_polygon(polyC, colors)
	draw_polygon(polyD, colors)
	

func actor_setup():
	
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(delta):
	
	if sleep:
		wait -= 1
		if wait <= 0:
			#sleep = false
			pass
		
		return
	
	
	# Go to player
	if player:
		
		# Set speed to be faster if far away
		movement_speed = 30.0 + 0.6*position.distance_to(player.position)
		
		movement_target_position = player.position
		set_movement_target(movement_target_position)
	
	if navigation_agent.is_navigation_finished():
		
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed
	
	direction = position.direction_to(next_path_position)
	
	# Scream
	if player:
		if position.distance_to(player.position) < 70:
			mouthTurn = lerp( mouthTurn, PI/6, 0.2)
			
			if soundlatch:
				$AudioStreamPlayer2D.play()
				soundlatch = false
				
		else:
			mouthTurn = lerp( mouthTurn, 0.0, 0.2)

	velocity = new_velocity
	move_and_slide()
	
	queue_redraw()
	
