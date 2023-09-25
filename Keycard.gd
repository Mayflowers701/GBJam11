extends Node2D


@export var type = "card" # or power
@export var value = "A" # B, C, Jump, Sprint

var time = 0
var init_y


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$CanvasLayer/Label.hide()
	
	z_index = 2
	init_y = position.y
	
	if value == 'A':
		$Keycards.frame = 0
	if value == 'B':
		$Keycards.frame = 1
	if value == 'C':
		$Keycards.frame = 2
		
	if value == "Jump":
		$Keycards.hide()
		$Powers.show()
		$Powers.animation = "Starjump"
		
	if value == "Sprint":
		$Keycards.hide()
		$Powers.show()
		$Powers.animation = "Shadowrun"
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += 1
	
	position.y += 0.15*sin(0.05*time)
	
	#if ($Area2D/CollisionShape2D.)
	
	


func _on_collect_area_body_entered(body):
	if body is Player:
		if value == 'A':
			PlayerSingleton.hasA = true
		if value == 'B':
			PlayerSingleton.hasB = true
		if value == 'C':
			PlayerSingleton.hasC = true
		if value == 'Jump':
			PlayerSingleton.hasDoubleJump = true
		if value == "Sprint":
			PlayerSingleton.hasSprint = true
		$Jingle.play()
		$AudioStreamPlayer2D.stop()
		$Keycards.hide()
		$Powers.hide()
		
		if value != 'A' && value != 'B' && value != 'C':
			$CanvasLayer/Label.z_index = 50
			if value == "Jump":
				$CanvasLayer/Label.text = "Double Jump"
			elif value == "Sprint":
				$CanvasLayer/Label.text = "Speed Booster"
			$CanvasLayer/Label.show()
		
		await( $Jingle.finished )
		queue_free()
		
	
	
	pass # Replace with function body.
