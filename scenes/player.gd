
#slidy player controller


extends CharacterBody2D

const ACCELERATION = 200.0
const JUMP_VELOCITY = -200.0
const MAX_SPEED = 200

var friction = 0.1
var gravity = 500

@onready var sprite = $AnimatedSprite2D
@onready var sndskid = $sndskid

func _ready():
	pass


func _physics_process(delta):
	
	
	
	
	
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x += direction * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		sprite.set_flip_h(direction < 0 )
	
	if (velocity.x < -1 || velocity.x > 1 ):
		sprite.play("run")
		sprite.set_speed_scale(clamp(0.02*(direction*velocity.x), 1, MAX_SPEED))
		
		
	
	
	if ((velocity.x<-50 && direction>0) || (velocity.x>50 && direction<0)) && is_on_floor():
		sprite.play("run")
		sprite.set_speed_scale(4)
		if not sndskid.is_playing():
			sndskid.play()
	else:
		sndskid.stop()
		
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY - 0.1*(direction*velocity.x)
			
		if direction == 0:
			velocity.x = lerp(velocity.x, 0, friction)
			
		if velocity.x < 1 && velocity.x > -1:
			sprite.set_speed_scale(1)
			sprite.play("still")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite.play("jump")
		
	
	
	move_and_slide()
