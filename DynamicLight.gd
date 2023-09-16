extends Control

var playerPos
var screen_points

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("/root/World/Player")
	if player:
		playerPos = player.position

func _draw():
	#draw_line(Vector2(0, 0), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	#draw_line(Vector2(0, 144), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	draw_line(Vector2(160, 144), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	draw_line(Vector2(160, 0), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	#draw_polygon()
	#draw_circle(playerPos, 10.0, Color(0,0,0,1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Get player and queue redraw
	
	var player = get_node("/root/World/Player")
	if player:
		playerPos = player.position
	
	queue_redraw()
	
	
	# Follow Player
	#position.x = playerPos.x;
