extends CharacterBody2D

@export var req_card = "A"

var open = false
var open_pos = -24
var close_pos = 0

var init_pos

func _ready():
	
	if req_card == 'A':
		$CardSign.frame = 0
	if req_card == 'B':
		$CardSign.frame = 1
	if req_card == 'C':
		$CardSign.frame = 2
	
	init_pos = position
	print( init_pos )
	print( position )
	


func _physics_process(delta):
	
	if init_pos:
		if open:
			position.y = lerp( position.y, init_pos.y + open_pos, 0.1)
		else:
			position.y = lerp( position.y, init_pos.y, 0.1)
	
	
	pass


func _on_motion_detector_body_entered(body):
	
	if body is Player:
		
		
		
		if req_card == 'A':
			if PlayerSingleton.hasA:
				print("OPENED!")
				if !open:
					$DoorSound.play()
				open = true
		if req_card == 'B':
			if PlayerSingleton.hasB:
				if !open:
					$DoorSound.play()
				open = true
		if req_card == 'C':
			if PlayerSingleton.hasC:
				if !open:
					$DoorSound.play()
				open = true
				
		
		
		
	pass # Replace with function body.
