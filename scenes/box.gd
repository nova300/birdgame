extends RigidDynamicBody2D

var held = false
var block = false

func _physics_process(delta):
	if held == true:
		self.position = get_node("../player/Pos2D").global_position
		self.set_freeze_enabled(true)
	elif self.is_freeze_enabled():
		self.set_freeze_enabled(false)
		
func _input(event):
	if Input.is_action_just_pressed("secondary") && block == false:
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "player" and get_node("../player").canhold == true:
				$sndpickup.play()
				held = true
				block = true
				get_node("../player").canhold = false

	if Input.is_action_just_pressed("secondary") && held == true && block == false:
		held = false
		$sndthrow.play()
		self.set_freeze_enabled(false)
		get_node("../player").canhold = true
		if get_node("../player").sprite.flip_h == false:
			apply_central_impulse(Vector2(250, -100))
		else:
			apply_central_impulse(Vector2(-250, -100))
	if Input.is_action_just_released("secondary"):
		block = false
