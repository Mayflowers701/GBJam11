extends Node2D

@onready var player = get_node("/root/World").get_node("Player")

# Collide with something on same collision layer (player)
func _on_area_2d_body_entered(body):
	player.keys.append(self.name)
	
	queue_free() # Renove key from scene
	pass # Replace with function body.
