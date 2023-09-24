extends Area2D

@export var target = load("res://Stage02.tscn")


func _on_stage_exit__botany_body_entered(body):
	get_tree().change_scene_to_file(target)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
