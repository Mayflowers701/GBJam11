extends Camera2D

# Player Object
@onready var player = $"../Player"

# Camera Variables
@export var cameraLead = 24	# Absolute value for camera lead
@export var cameraOffset = Vector2(8, 0) # Camera offset before moving
@export var cameraSpeed = 0.05
# var viewport # Game resolution
var cameraDirection = 1 # Directional camera lead

# Called when the node enters the scene tree for the first time.
func _ready():
	# viewport = get_viewport_rect().size
	position = player.position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta): #_process(delta)
	# Where the player is framed in camera
	var follow = Vector2(player.position) + Vector2(cameraLead * cameraDirection, 0)
	
	# Difference of player position and camera "center" (offsetted)
	var xDif = position.x - follow.x
	#var yDif = position.y - follow.y
	
	# Move camera in direction of player when player pushes against an offset border
	var newPos = position
	if(abs(xDif) >= cameraOffset.x):	# Horizontal
		if player.direction > 0:
			cameraDirection = 1
		elif player.direction < 0:
			cameraDirection = -1
		newPos.x = follow.x
		
	# if(abs(yDif) >= cameraOffset.y):	# Vertical
	#	newPos.y = follow.y
	
	# Change camera position
	position = lerp(position, newPos, cameraSpeed )
	
	pass
