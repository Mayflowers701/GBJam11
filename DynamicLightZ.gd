extends Control

var playerPos
var playerFacing
var screen_points
var parentPos
var shadowPoints
var shadowColor = [Color.hex(0x170a22ff)]
var lightWidth = 200
var lightDirection = 0.0

var testPoly
var collisionMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("/root/World/Player")
	if player:
		playerPos = player.position
		playerFacing = player.facing
	parentPos = get_canvas_transform()
	
	#testPoly = get_node("/root/World/CollisionMap/LightingTestPolygon")
	collisionMap = get_node("/root/World/ZShadows")
	
	# CRITICAL
	z_index = 1

func _draw():
	#draw_line(Vector2(0, 0), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	#draw_line(Vector2(0, 144), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	#draw_line(Vector2(160, 144), Vector2(playerPos.x + parentPos.origin.x, playerPos.y), Color.GREEN, 1.0)
	#draw_line(Vector2(160, 0), Vector2(playerPos.x, playerPos.y), Color.GREEN, 1.0)
	#draw_polygon()
	#draw_circle(playerPos, 10.0, Color(0,0,0,1))
	#draw_line(Vector2(5*playerFacing, 0), Vector2(160*playerFacing, -144), Color.GREEN, 1.0)
	#draw_line(Vector2(5*playerFacing, 0), Vector2(160*playerFacing, 144), Color.GREEN, 1.0)
	
	#shadowPoints = [Vector2(0*playerFacing,-7),Vector2(160*playerFacing, -lightWidth/2 + lightDirection), Vector2(160*playerFacing,-144- abs(lightDirection)),Vector2(-160*playerFacing,-144), Vector2(-160*playerFacing, 144), Vector2(160*playerFacing,144+ abs(lightDirection)), Vector2(160*playerFacing, lightWidth/2 + lightDirection), Vector2(0*playerFacing,7),Vector2(-6*playerFacing, 3),Vector2(-7*playerFacing, 0),Vector2(-6*playerFacing, -3)]
	#draw_polygon(shadowPoints, shadowColor)
	

	# Light Raycasting!
	# Iterate through all CollisionPolygon2D within the CollisionMap
	if collisionMap:
		for child_index in range(collisionMap.get_child_count()):
			
			# Check if this child is a CollisionPolygon2D node
			var child = collisionMap.get_child(child_index)
			if child is Line2D:
				var colPosX = child.position.x
				var colPosY = child.position.y
				
				var space_state = get_world_2d().direct_space_state
				var poly = child.points
				#var globalTrans = child.get_global_transform()
				
				for pt_index in child.points.size():
					"""
					var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), Vector2(point.x, point.y))
					var result = space_state.intersect_ray(query)
					if result:
						draw_line(Vector2(0, 0), Vector2(result.position.x - get_parent().position.x, result.position.y - get_parent().position.y), Color.GREEN, 1.0)
					"""
					var point = child.points[pt_index]
					var nextPoint
					
					# If we're at the end of the polygon, the first vertex is next
					if pt_index < child.points.size()-1:
						nextPoint = child.points[pt_index+1]
					else:
						break
						
					var projectDistance = 1600
					
					# Get x proportion from player compared to edge of screen
					var ratio = projectDistance / (point.x - get_parent().position.x + colPosX)
					var height = ratio*(point.y - get_parent().position.y + colPosY)
					var shadowDir = sign(ratio)
					if shadowDir == 0:
						shadowDir = 1;
					var shadowVert = sign( point.y - get_parent().position.y )
					
					var nextRatio = projectDistance / (nextPoint.x - get_parent().position.x  + colPosX)
					var nextHeight = nextRatio*(nextPoint.y - get_parent().position.y + colPosY)
					var nextShadowDir = sign(nextRatio)
					if nextShadowDir == 0:
						nextShadowDir = 0
					var nextShadowVert = sign( nextPoint.y - get_parent().position.y )
					
					# Create our four points for our polygon
					# This point
					var A = Vector2(point.x - get_parent().position.x + colPosX , point.y - get_parent().position.y + colPosY )
					# It's vanishing extension
					var B = Vector2(projectDistance*shadowDir, height*shadowDir)
					# The nex point's vanishing extension
					var D = Vector2(nextPoint.x - get_parent().position.x + colPosX , nextPoint.y - get_parent().position.y + colPosY )
					# The next point
					var C = Vector2(projectDistance*nextShadowDir, nextHeight*nextShadowDir)
				
					draw_polygon([A,B,C],shadowColor)
					draw_polygon([A,C,D],shadowColor)
					
					#draw_line(A,B,Color.GREEN, 1.0)
					#draw_line(B,C,Color.RED, 1.0)
					#draw_line(C,D,Color.GREEN, 1.0)
					#draw_line(D,A,Color.GREEN, 1.0)
					
					#draw_line(Vector2(160*shadowDir, height*shadowDir), Vector2(point.x - get_parent().position.x, point.y - get_parent().position.y), Color.GREEN, 1.0)
					



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
