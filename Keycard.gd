extends Node2D

var time = 0
var init_y


# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = 2
	init_y = position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += 1
	
	position.y += 0.15*sin(0.05*time)
	
	#if ($Area2D/CollisionShape2D.)
	
