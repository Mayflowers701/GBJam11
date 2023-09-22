extends CharacterBody2D

@export var width = 2
@export var nextName = "Head"
var nextSeg
var movement_speed = 0

var movement_target_position: Vector2 = Vector2(60.0,180.0)

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	nextSeg = get_node("../Seg" + str(nextName))
	
	pass # Replace with function body.


func _draw():
	
	#draw_circle(Vector2(0,0), width, Color.hex(0x000000ff))
	
	if nextSeg:
		#draw_line( Vector2(0,0), nextSeg.position - position, Color.hex(0x000000ff))
		
		var A = Vector2(1,0).rotated( direction.angle() + PI/2 ) * width 
		var B = Vector2(1,0).rotated( direction.angle() - PI/2 ) * width 
		var C = nextSeg.position - position + Vector2(1,0).rotated( direction.angle() - PI/2 ) * width/2
		var D = nextSeg.position - position + Vector2(1,0).rotated( direction.angle() + PI/2 ) * width/2
		
		var segPoints = [A, B, C, D]
		var segColor = [Color.hex(0x000000ff)]
		
		draw_polygon(segPoints, segColor)
		draw_line( Vector2(0,0), nextSeg.position - position, Color.hex(0x000000ff))
	
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	call_deferred("actor_setup")
	#print("What?")
	pass
	

func actor_setup():
	
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)
	

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#print("HELLO?")
	
	nextSeg = get_node("../Seg" + str(nextName))
	if nextSeg:
		movement_speed = nextSeg.movement_speed
	
	queue_redraw()
	
	# If next segment is too far away, approach it
	if nextSeg:
		movement_target_position = nextSeg.position
		set_movement_target(movement_target_position)
		
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
		
		if position.distance_to(nextSeg.position) > 10:
			#print(position.x)
			#print(nextSeg.position.x)
			var new_velocity: Vector2 = next_path_position - position
			new_velocity = new_velocity.normalized()
			new_velocity = new_velocity * movement_speed
			
			direction = position.direction_to(next_path_position)
			
			velocity = new_velocity
			move_and_slide()
	
	pass
