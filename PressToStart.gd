extends Label

var delay = 200
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
	
	if Input.is_action_pressed("game_z"):
		get_tree().change_scene_to_file("res://TitleCard.tscn")
	
	pass
