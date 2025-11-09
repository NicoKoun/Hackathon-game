extends CharacterBody2D
const SPEED = 150.0
#ADD AUDIO
@onready var sfx_walk: AudioStreamPlayer2D = $sfx_walk
@onready var sfx_hurt: AudioStreamPlayer2D = $sfx_hurt

var lastkey = "down"
var invince = false
var ishurt = false
var Attack = false


func _ready():
	self.position = Game.playerposition

func _physics_process(delta: float) -> void:
	var directionx = Input.get_axis("Left", "Right")
	var directiony = Input.get_axis("Up", "Down")
	if directionx and Game.canmove == true and Game.dead == false:
		velocity.x = directionx * SPEED
		if directionx == -1:
			if !directiony:
				get_node("AnimatedSprite2D").play("walkleft")
			lastkey = "left"
		elif directionx == 1:
			if !directiony:
				get_node("AnimatedSprite2D").play("walkright")
			lastkey = "right"
	else:
		velocity.x = 0 
		if lastkey == "right" and Attack == false and Game.got == false and Game.dead == false:
			get_node("AnimatedSprite2D").play("right")
		elif lastkey == "left" and Attack == false and Game.got == false and Game.dead == false:
			get_node("AnimatedSprite2D").play("left")
	if directiony and Game.canmove == true and Game.dead == false:
		velocity.y = directiony * SPEED
		if directiony == -1:
			get_node("AnimatedSprite2D").play("walkup")
			lastkey = "up"
		elif directiony == 1:
			get_node("AnimatedSprite2D").play("walkdown")
			lastkey = "down"
	else:
		velocity.y = 0
		if lastkey == "up" and Attack == false and Game.got == false and Game.dead == false:
			get_node("AnimatedSprite2D").play("up")
		elif lastkey == "down" and Attack == false and Game.got == false and Game.dead == false:
			get_node("AnimatedSprite2D").play("down")
		
	if Input.is_action_just_pressed("Attack") and Game.sword == true:# or Game.got == true and Game.sword and Game.dead == false:
		#var actionables = actionable_finder.get_overlapping_areas()
		
		Game.canmove = false
		Game.sword = false
		velocity.y = 0 
		velocity.x = 0
		#thing for dialogue and interacting
		#if actionables.size()>0:
			#print(actionables[0])
			#actionables[0].action()
		#else:

		attack()
	#if lastkey == "up":
		#$Direction.rotation = PI
	#elif lastkey == "down":
		#$Direction.rotation = 0
	#elif lastkey == "left":
		#$Direction.rotation = PI/2
	#elif lastkey == "right":
		#$Direction.rotation = PI*3/2
		
	while ishurt == true:
		if lastkey == "up":
			velocity.y = 800 
			
		elif lastkey == "down":
			velocity.y = -800 
		elif lastkey == "right":
			velocity.x = -800 
		else:
			velocity.x = 800
		break
	if Game.playerHP <= 0: 
		self.velocity = Vector2(0,0)
		if Game.dead == false:
			death()
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	var camera = $"../Camera2D"
	if self.global_position.x > camera.global_position.x + 384:
		camera.global_position.x += 800
	elif self.global_position.x < camera.global_position.x - 384:
		camera.global_position.x -= 800
	if self.global_position.y > camera.global_position.y + 228:
		camera.global_position.y += 448
	elif self.global_position.y < camera.global_position.y - 228:
		camera.global_position.y -= 448
		
	Game.camchange = true
	
func gethurt():
	if Game.dead == true:
		return
	$hurttimer.start()
	$invincetimer.start()
	sfx_hurt.play()
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(3, false)
	set_collision_mask_value(3, false)
	ishurt = true
	invince = true
	#Game.canmove = false
	$AnimatedSprite2D.material.set_shader_parameter("active", true)
	await get_tree().create_timer(0.2).timeout
	$AnimatedSprite2D.material.set_shader_parameter("active", false)
	
func _on_hurttimer_timeout():
	$hurttimer.stop()
	ishurt = false
	if Game.dead == false:
		#Game.canmove = true
		velocity.x = 0
		velocity.y = 0
		$invincetimer.start()
		$blinktimer.start()

func _on_invincetimer_timeout():
	$invincetimer.stop()
	$blinktimer.stop()
	self.visible = true
	invince = false
	get_node("AnimatedSprite2D").visible = true
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)




func _on_blinktimer_timeout():
	get_node("AnimatedSprite2D").visible = !get_node("AnimatedSprite2D").visible

func death():
	#print("ASFDASFADFASDf")
	##Temporary death script, does an animation before starting a timer to respawn the player.
	#get_node("AnimatedSprite2D").visible = true
	##Game.muted = true
	#$invincetimer.stop()
	#Game.sword = false
	##var camera = $"../Camera2D"
	#Game.boss = false
	#set_collision_layer_value(1, false)
	#set_collision_mask_value(1, false)
	#set_collision_layer_value(2, false)
	#set_collision_mask_value(2, false)
	##camera.get_child(0).visible = true add this back
	#for n in range(1, 7):
		#get_node("AnimatedSprite2D").visible = !get_node("AnimatedSprite2D").visible
		#await get_tree().create_timer(0.1).timeout
		#
	#get_node("AnimatedSprite2D").play("death")
	##$AudioStreamPlayer.play()
	#await get_node("AnimatedSprite2D").animation_finished
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
	#$deathTimer.start()



#func _on_death_timer_timeout():
	#
	#var camera = $"../Camera2D"
	#self.position = Vector2(2960, 5272)
	#camera.position_smoothing_enabled = false
	#camera.position = Vector2(2960, 5184)
	#Game.playerHP = 30
	#Game.bossHP = 30
	#Game.dead = false
	#invince = false
	#set_collision_layer_value(1, true)
	#set_collision_mask_value(1, true)
	#set_collision_layer_value(2, true)
	#set_collision_mask_value(2, true)
	#get_node("AnimatedSprite2D").visible = true
	#Game.canmove = true
	#Game.sword = true
	#camera.get_child(0).visible = false
	#await get_tree().create_timer(0.1).timeout
	#Game.muted = false
	#camera.position_smoothing_enabled = true


func attack():
	$sword.init(lastkey)
	Attack = true
	if lastkey == "up" and Game.dead == false:
		get_node("AnimatedSprite2D").play("attackup")
	elif lastkey == "down" and Game.dead == false:
		get_node("AnimatedSprite2D").play("attackdown")
	elif lastkey == "right" and Game.dead == false:
		get_node("AnimatedSprite2D").play("attackright")
	elif lastkey == "left" and Game.dead == false:
		get_node("AnimatedSprite2D").play("attackleft")
