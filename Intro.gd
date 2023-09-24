extends Node2D

var wait = 60
var time = 0;

var light = false
signal lit

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = 5

	pass # Replace with function body.
	

func _draw():
	draw_arc(Vector2(0,0), 80 + pow(time, 0.5), 1.0, 1+TAU, 50, Color.hex(0x252525ff), 160.0, false)
	#draw_arc()
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position.x = get_node("/root/World/Player").position.x
	position.y = get_node("/root/World/Player").position.y
	
	wait -=1
	
	if wait <= 0:
		
		queue_redraw()
		time += 150
		
		if !light:
			$FlashlightSound.play()
			light = true
			lit.emit()
		
	
	if sqrt(time) >= 160:
		queue_free()
	
	pass
