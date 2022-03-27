extends CharacterBody2D

const ACCELERATION = 100.0
const JUMP_VELOCITY = -200.0
const MAX_SPEED = 150

var friction = 100
var gravity = 350



func _physics_process(delta):
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x += direction * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	if ((velocity.x<-50 && direction>0) || (velocity.x>50 && direction<0)) && is_on_floor():
		if not $sndskid.is_playing():
			$sndskid.play()
	else:
		$sndskid.stop()
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY - 0.1*(direction*velocity.x)
		
		
	$Label.text = str($sndskid.is_playing())
	move_and_slide()
