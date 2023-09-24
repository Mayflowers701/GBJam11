extends AudioStreamPlayer

var sound = load("res://Sounds/Footstep_1.mp3")


func play_sound():
	
	
	stream = sound
	play()
	
	sound = load("res://Sounds/Footstep_" + str(randi()%5+1) + ".mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
