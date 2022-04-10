extends CharacterBody2D

const SPEED = 10

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = 500
var direction = -1 # -1 is left 1 is right 0 is stationary
var dead = false

func _physics_process(delta):
	# Add the gravity.
	if is_on_wall():
		direction = direction * -1
		$AnimatedSprite2D.set_flip_h((-1* direction) < 0 )
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite2D.play("falling")
	
	if is_on_floor():
		velocity.x = direction * SPEED 
		$AnimatedSprite2D.play("default")
	
	if dead:
		$CollisionShape2D.set_disabled(true)
		$CollisionShape2D2.set_disabled(true)
	
	move_and_slide()


func _on_hitbox_body_entered(body):
	if body.linear_velocity != Vector2(0, 0):
		velocity.y = -200
		velocity.x = 20 * direction
		dead = true
		$snd.play()# Replace with function body.
