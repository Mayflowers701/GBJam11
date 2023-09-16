extends Control

var playerPos

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("/root/World/Player")
	if player:
		playerPos = player.position

func _draw():
	draw_line(Vector2(0, 0), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var player = get_node("/root/World/Player")
	if player:
		playerPos = player.position
		
	queue_redraw()
