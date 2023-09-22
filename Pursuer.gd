extends Area2D

@onready var navigation_agent = $NavigationAgent2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _draw():
	draw_circle(Vector2(0,0), $CollisionCircle.shape.radius, Color.hex(0x000000ff))
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	
	# Move towards target
	
	
	pass
