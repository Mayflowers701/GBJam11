extends Label

var timer = 170

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timer -= 1
	if timer <= 0:
		queue_free()
	
	pass
