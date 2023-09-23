extends Label

var delay = 220
var flip = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	delay -= 1
	if delay <= 0:
		show()
	
	pass
