extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = float(get_parent().facing * 40)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position.x = lerp(position.x, float(get_parent().facing * 40), 0.05)
	#position.y = get_parent().position.y
	
	#pass
