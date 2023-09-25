extends StaticBody2D

var broken = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	
	
	
	if body is Player:
		
		if body.isSprint:
			
			if !broken:
				broken = true
				print("HIT")
				
				$AudioStreamPlayer2D.play()
				$CollisionPolygon2D.queue_free()
				hide()
				
				await( $AudioStreamPlayer2D.finished )
				queue_free()
	
	pass # Replace with function body.
