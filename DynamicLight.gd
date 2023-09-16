extends Control

var playerPos
var playerFacing
var screen_points
var parentPos
var shadowPoints
var shadowColor = [Color(0,0,0,1)]
var lightWidth = 150
var lightDirection = 0.0

var testPoly

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("/root/World/Player")
	if player:
		playerPos = player.position
		playerFacing = player.facing
	parentPos = get_canvas_transform()
	
	testPoly = get_node("/root/World/CollisionMap/LightingTestPolygon")

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
	#draw_polygon(shadowPoints, shadowColor)
	

	# Raycast Testing
	if testPoly:
		var space_state = get_world_2d().direct_space_state
		var poly = testPoly.polygon
		for point in poly:
			"""
			var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), Vector2(point.x, point.y))
			var result = space_state.intersect_ray(query)
			if result:
				draw_line(Vector2(0, 0), Vector2(result.position.x - get_parent().position.x, result.position.y - get_parent().position.y), Color.GREEN, 1.0)
			"""
			
			# Get x proportion from player compared to edge of screen
			var ratio = 160 / (point.x - get_parent().position.x)
			var height = ratio*(point.y - get_parent().position.y)
			
			draw_line(Vector2(160*sign(ratio), height*sign(ratio)), Vector2(point.x - get_parent().position.x, point.y - get_parent().position.y), Color.GREEN, 1.0)
				



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
