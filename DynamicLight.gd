extends Control

var playerPos
var playerFacing
var screen_points
var parentPos
var shadowPoints
var shadowColor = [Color(0,0,0,1)]
var lightWidth = 150
var lightDirection = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("/root/World/Player")
	if player:
		playerPos = player.position
		playerFacing = player.facing
	parentPos = get_canvas_transform()

func _draw():
	#draw_line(Vector2(0, 0), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	#draw_line(Vector2(0, 144), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	#draw_line(Vector2(160, 144), Vector2(playerPos.x + parentPos.origin.x, playerPos.y), Color.GREEN, 1.0)
	#draw_line(Vector2(160, 0), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	#draw_polygon()
	#draw_circle(playerPos, 10.0, Color(0,0,0,1))
	#draw_line(Vector2(5*playerFacing, 0), Vector2(160*playerFacing, -144), Color.GREEN, 1.0)
	#draw_line(Vector2(5*playerFacing, 0), Vector2(160*playerFacing, 144), Color.GREEN, 1.0)
	
	shadowPoints = [Vector2(0*playerFacing,-7),Vector2(160*playerFacing, -lightWidth/2 + lightDirection), Vector2(160*playerFacing,-144- abs(lightDirection)),Vector2(-160*playerFacing,-144), Vector2(-160*playerFacing, 144), Vector2(160*playerFacing,144+ abs(lightDirection)), Vector2(160*playerFacing, lightWidth/2 + lightDirection), Vector2(0*playerFacing,7),Vector2(-6*playerFacing, 3),Vector2(-7*playerFacing, 0),Vector2(-6*playerFacing, -3)]
	draw_polygon(shadowPoints, shadowColor)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Get player and queue redraw
	
	var player = get_node("/root/World/Player")
	if player:
		playerPos = player.position
		playerFacing = player.facing
		
	parentPos = get_canvas_transform()
	
	queue_redraw()
	
	
	# Follow Player
	#position.x = playerPos.x;
