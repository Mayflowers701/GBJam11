extends StaticBody2D

@onready var player = get_node("/root/World").get_node("Player")

# Collide with something on same collision layer (player)
func _on_area_2d_body_entered(body):
	if self.name in player.keys:
		get_node("CollisionShape2D").set_deferred("disabled", true) # '.disabled = true' doesn't work for whatever reason
		get_node("Sprite").visible = false
				
	pass # Replace with function body.
