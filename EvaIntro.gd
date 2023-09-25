extends Node2D

var time = 1
var rad = 0

var rectTime = 0
var rectWTime = 0
var rectH = 0
var rectW = 0

@export var ending = false
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
	
	draw_rect(Rect2(Vector2(-rectW,-rectH), Vector2(2*rectW,2*rectH)), Color.hex(0x170a22ff), true)
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

	
	time += 200
	if get_parent().timer > 0:
		pass
	else:
		rectTime += 1
		rectH = sqrt(rectTime*150)
		rectW = 1
		if rectH > (144/2):
			rectWTime +=1
			rectW = sqrt(rectWTime*150)
		#rectW = rectTime
		pass


	if rectWTime >= 120:
		if !ending:
			get_tree().change_scene_to_file("res://Stage01.tscn")
	rad = pow(time, (1/2.0))
		
	pass
