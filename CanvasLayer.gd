extends CanvasLayer

var time = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	time -= 1
	if time <=0:
		hide()
	
	pass
