extends KinematicBody2D


const moveSpeed = 25
export (float) var maxSpeed = 120
export (float) var jumpHeigth = -400
const up = Vector2(0,-1)
const gravity = 15 
onready var animatedSprite = $AnimatedSprite
var motion = Vector2()


func _physics_process(delta):
	motion.y += gravity
	var friction = false
	if Input.is_action_pressed("ui_right"):
		animatedSprite.flip_h = false
		animatedSprite.play("run")
		motion.x = min(motion.x + moveSpeed, +maxSpeed)
	
	elif Input.is_action_pressed("ui_left"):
		animatedSprite.flip_h = true
		animatedSprite.play("run")
		motion.x = max(motion.x - moveSpeed,  -maxSpeed)	

	else:
		animatedSprite.play("idle")
		friction = true

	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = jumpHeigth
		if friction == true:
			motion.x = lerp(motion.x ,0 ,0.1)
	else:
		if friction == true:
			if motion.y < -1:
				$AnimatedSprite.play("jump")
			if motion.y > 1:
				$AnimatedSprite.play("fall")
			motion.x = lerp(motion.x, 0, 0.01)
			

		
			
	motion = move_and_slide(motion, up)
				
