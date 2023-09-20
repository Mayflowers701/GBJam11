extends Camera2D

@onready var LEAD = position.x		# Taken from 'Transform/Position.x' in the inspector
@export var SPEED = 0.05			# Publically configurable from the inspector

var last_pos
var current_pos
var facing			# O

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize came
	current_pos = get_screen_center_position()
	last_pos =  current_pos
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Update camera lead direction when player reaches drag margin, pushing the camera
	current_pos = get_screen_center_position()
	if current_pos != last_pos:
		last_pos = current_pos
		facing = get_parent().facing
		position.x = lerp(position.x, LEAD * facing, SPEED)

	pass
