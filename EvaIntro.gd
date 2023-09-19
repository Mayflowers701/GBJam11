extends Node2D

var time = 1
var rad = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _draw():
	
	for i in 20:
		draw_circle(Vector2(0,0), max((rad - i*15), 0), Color.hex(0xf9f8ddff))
		draw_circle(Vector2(0,0), max(rad - (i*15) - (i*2), 0), Color.hex(0x170a22ff))
	"""
	draw_circle(Vector2(0,0), rad, Color.hex(0xf9f8ddff))
	draw_circle(Vector2(0,0), rad-2, Color.hex(0x170a22ff))
	
	draw_circle(Vector2(0,0), rad-20, Color.hex(0xf9f8ddff))
	draw_circle(Vector2(0,0), rad-24, Color.hex(0x170a22ff))
	
	draw_circle(Vector2(0,0), rad-40, Color.hex(0xf9f8ddff))
	draw_circle(Vector2(0,0), rad-48, Color.hex(0x170a22ff))
	"""
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

	
	
	if get_parent().timer > 0:
		time += 200
	else:
		time -= 1000


	if time < 0:
		get_tree().change_scene_to_file("res://Stage01.tscn")
	rad = pow(time, (1/2.0))
		
	pass
