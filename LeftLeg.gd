extends CharacterBody2D

var partner

@export var left = true
var offset = 40
var rotateDir = 1
var parentDir = 0
var angle = 0.4

var targetPos = Vector2(0,0)
var newPos = position

var moving = false


func _on_ready():

	if left:
		moving = true
	
	pass

func _draw():
	draw_circle(Vector2(0,0), 2, Color.hex(0xff00ffff))
	
	draw_line(Vector2(0,0), get_parent().get_parent().position-position, Color.hex(0x000000ff))
	#Vector2(1,0).rotated( parentDir+ angle*rotateDir)*offset, 

func _physics_process(delta):
	
	if left:
		partner = $"../RightLeg"
	else:
		partner = $"../LeftLeg"
	
	parentDir = get_parent().get_parent().direction.angle()
	
	if left:
		rotateDir = -1
		#position.x = offset
	
	targetPos = get_parent().get_parent().position + Vector2(1,0).rotated( parentDir+ angle*rotateDir)*offset
	#newPos = lerp(position, targetPos, 0.5)
	
	if position.distance_to(targetPos) > offset && !partner.moving:
		newPos = targetPos
		moving = true
		
	if position.distance_to(newPos) < 2:
		moving = false
	
	if partner:
		if moving:
			position = lerp(position, newPos, 0.5)
	
	queue_redraw()

	#move_and_slide()
