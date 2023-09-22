extends CharacterBody2D

var partner

var offset = 30
var limbA = 10
var limbB = 10

@export var left = true

var rotateDir = 1
var parentDir = 0
var angle = 0.3

var targetPos = Vector2(0,0)
var newPos = position

var moving = false
var movingLatch = true

var a
var b
var c
var elbow = Vector2(0,0)

var facing = 1

var legDir

@onready var sound = $AudioStreamPlayer2D

func _on_ready():

	if left:
		moving = true
	
	pass

func _draw():
	draw_circle(Vector2(0,0), 2, Color.hex(0x000000ff))
	
	#draw_line(Vector2(0,0), get_parent().get_parent().position-position, Color.hex(0x0000ffff))
	
	#draw_circle(elbow, 1, Color.hex(0x00ffffff))
	draw_line( Vector2(0,0), elbow, Color.hex(0x000000ff))
	draw_line( get_parent().get_parent().position-position, elbow, Color.hex(0x000000ff))

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
	
	if position.distance_to(targetPos) > 1.5*offset && !partner.moving:
		newPos = targetPos
		facing = sign( position - targetPos )
		moving = true
		
	if position.distance_to(newPos) < 2:
		moving = false
	
	if partner:
		if moving:
			position = lerp(position, newPos, 0.25)
			

	# "Torque"
	"""
	if moving:
		legDir = Vector2(0,0).direction_to(get_parent().get_parent().position).angle()
		get_parent().get_parent().position += Vector2(1,0).rotated(legDir) * 0.1
	"""
	
	queue_redraw()
	
	# INVERSE KINEMATICS!
	a = limbA
	b = limbB
	c = Vector2(0,0).distance_to(get_parent().get_parent().position-position)

	var beta = acos( ( pow(c, 2) + pow(a, 2) - pow(b, 2) ) / (2*c*a) )
	elbow = Vector2(1,0).rotated( beta ) * a * facing
	#move_and_slide()
