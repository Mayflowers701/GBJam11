extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$A.frame = 0
	$B.frame = 1
	$C.frame = 2
	$Jump.frame = 3
	$Sprint.frame = 4
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if PlayerSingleton.hasA:
		$A.show()
	else:
		$A.hide()
		
	if PlayerSingleton.hasB:
		$B.show()
	else:
		$B.hide()
		
	if PlayerSingleton.hasC:
		$C.show()
	else:
		$C.hide()
		
	if PlayerSingleton.hasDoubleJump:
		$Jump.show()
	else:
		$Jump.hide()
		
	if PlayerSingleton.hasSprint:
		$Sprint.show()
	else:
		$Sprint.hide()
	
	pass
