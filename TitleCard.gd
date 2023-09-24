extends Node2D

var timer = 180

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Begin intro music
	MusicController.play_music()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timer -= 1
		
	if Input.is_action_just_pressed("game_z"):
		get_tree().change_scene_to_file("res://Stage01.tscn")
	
	pass
