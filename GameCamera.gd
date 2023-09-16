extends Camera2D

# Track the position of the camera corners for the sake fo drawing shadows



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position.x = lerp(position.x, float(get_parent().facing * 20), 0.05)
	
	pass
