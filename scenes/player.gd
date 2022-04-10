
#slidy player controller


extends CharacterBody2D

signal hit

const ACCELERATION = 200.0
const JUMP_VELOCITY = -200.0
const MAX_SPEED = 150

var friction = 0.05
var gravity = 500
var canhold = true
var spriteholding = false
var health = 3
var dead = false

@onready var sprite = $AnimatedSprite2D
@onready var sndskid = $sndskid
@onready var sndjump = $sndjump

func _ready():
	pass


func _physics_process(delta):
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x += direction * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		sprite.set_flip_h(direction < 0 )
	
	if (velocity.x < -1 || velocity.x > 1 ):
		if canhold:
			sprite.play("run")
		else:
			sprite.play("run_holding")
		sprite.set_speed_scale(clamp(0.02*(direction*velocity.x), 1, MAX_SPEED))
		
		
	
	
	if ((velocity.x<-50 && direction>0) || (velocity.x>50 && direction<0)) && is_on_floor():
		if canhold:
			sprite.play("run")
		else:
			sprite.play("run_holding")
		sprite.set_speed_scale(4)
		sndskid.set_pitch_scale(clamp(0.02*(-1*direction*velocity.x), 0.5, 1.2))
		if not sndskid.is_playing():
			sndskid.play()
	else:
		sndskid.stop()
		
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("primary"):
			velocity.y = JUMP_VELOCITY - 0.1*(direction*velocity.x)
			sndjump.play()
			
		if direction == 0:
			velocity.x = lerp(velocity.x, 0, friction)
			
		if velocity.x < 1 && velocity.x > -1:
			sprite.set_speed_scale(1)
			if canhold:
				sprite.play("still")
			else:
				sprite.play("still_holding")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if canhold:
			sprite.play("jump")
		else:
			sprite.play("jump_holding")
		
		

	move_and_slide()


func _on_area_2d_body_entered(body):
	health -= 1
	if health == 0:
		dead = true
	
func start(pos):
	position = pos
	show()
	$Area2D/Hitbox.disabled = false


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
