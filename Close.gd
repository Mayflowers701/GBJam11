extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_motion_sensor_body_exited(body):
	if body is Player:
		play()
	pass # Replace with function body.
