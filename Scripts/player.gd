extends CharacterBody2D
const SPEED = 150.0

var lastkey = "down"
var invince = false
var ishurt = false
var Attack = false
func _physics_process(delta: float) -> void:
	var directionx = Input.get_axis("left", "right")
	var directiony = Input.get_axis("up", "down")
	if directionx: #and Game.canmove == true and Game.dead == false:
		velocity.x = directionx * SPEED
		
		if directionx == -1:
			if !directiony:
				get_node("AnimatedSprite2D").play("walkleft")
			#lastkey = "left"
		elif directionx == 1:
			if !directiony:
				get_node("AnimatedSprite2D").play("walkright")
			#lastkey = "right"
	else:
		velocity.x = 0 
		if lastkey == "right":# and Attack == false and Game.got == false and Game.dead == false:
			get_node("AnimatedSprite2D").play("right")
		elif lastkey == "left":# and Attack == false and Game.got == false and Game.dead == false:
			get_node("AnimatedSprite2D").play("left")
	if directiony:# and Game.canmove == true and Game.dead == false:
		velocity.y = directiony * SPEED
		if directiony == -1:
			get_node("AnimatedSprite2D").play("walkup")
			#lastkey = "up"
		elif directiony == 1:
			get_node("AnimatedSprite2D").play("walkdown")
			#lastkey = "down"
	else:
		velocity.y = 0 #move_toward(velocity.y, 0, SPEED)
		if lastkey == "up":# and Attack == false and Game.got == false and Game.dead == false:
			get_node("AnimatedSprite2D").play("up")
		elif lastkey == "down":# and Attack == false and Game.got == false and Game.dead == false:
			get_node("AnimatedSprite2D").play("down")
		
	#if Input.is_action_just_pressed("Interact") and Game.sword == true or Game.got == true and Game.sword and Game.dead == false:
		#var actionables = actionable_finder.get_overlapping_areas()
		#Game.canmove = false
		#Game.sword = false
		#velocity.y = 0 
		#velocity.x = 0
		#if actionables.size()>0:
			#print(actionables[0])
			#actionables[0].action()
		#else:
			#attack();
	#if lastkey == "up":
		#$Direction.rotation = PI
	#elif lastkey == "down":
		#$Direction.rotation = 0
	#elif lastkey == "left":
		#$Direction.rotation = PI/2
	#elif lastkey == "right":
		#$Direction.rotation = PI*3/2
	#while ishurt == true:
		#if lastkey == "up":
			#velocity.y = 800 
			#
		#elif lastkey == "down":
			#velocity.y = -800 
		#elif lastkey == "right":
			#velocity.x = -800 
		#else:
			#velocity.x = 800
		#break
	#if Game.playerHP <= 0: 
		#self.velocity = Vector2(0,0)
		#if Game.dead == false:
			#death()
	move_and_slide()
