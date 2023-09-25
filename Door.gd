extends AnimatedSprite2D

var open = false
var open_pos = -16.0
var close_pos = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var open_pos = position.y + -16.0
	var close_pos = position.y + 0.0
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if open:
		position.y = lerp( position.y, open_pos, 0.1)
	else:
		position.y = lerp( position.y, close_pos, 0.1)
	
	pass


func _on_motion_sensor_body_entered(body):
	if body is Player:
		open = true
	#$Open.play()
	
	
	pass # Replace with function body.


func _on_motion_sensor_body_exited(body):
	if body is Player:
		open = false
	#$Close.play()
	
	pass # Replace with function body.
