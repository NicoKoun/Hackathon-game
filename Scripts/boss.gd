extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dir = 1
#Change this to a rock
const Shoot = preload("res://Scenes/Rockthrow.tscn")
const Quake = preload("res://Scenes/Quake(1996).tscn")
#Also add quake attack.
var player
var prevdir = 1
var num = 0
var takingbreak = false
func _ready():
	#add audio stream player
	player = get_node("../../player/player")
	
	

func _physics_process(delta):
	if dir == 0:
		velocity.x = 0
		velocity.y = 0
	elif dir == 1:
		get_node("AnimatedSprite2D").play("idle right")
		velocity.x = SPEED
		velocity.y = 0
	elif dir == 2:
		get_node("AnimatedSprite2D").play("idle left")
		velocity.x = SPEED * -1
		velocity.y = 0
	elif dir == 3:
		get_node("AnimatedSprite2D").play("idle forward")
		velocity.x = 0
		velocity.y = SPEED
	elif dir == 4:
		get_node("AnimatedSprite2D").play("idle backward")
		velocity.x = 0
		velocity.y = SPEED * -1
		
	if(get_real_velocity() == Vector2(0,0)) and dir != 0:
		changedir()
	
	move_and_slide()
func _on_player_collision_body_entered(body):
	if body.name == "player":
		if body.invince == false:
			body.gethurt()
			Game.playerHP -= 3

func hurt():
	Game.bossHP -= 1
	var tween: Tween = create_tween()
	if Game.bossHP <= 0:
		death()
	else:
		tween.tween_property($AnimatedSprite2D, "modulate:v", 1, 0.25).from(15)
		$Timer.stop()
		$shootTimer.stop()
		prevdir = dir
		if prevdir == 0:
			prevdir = randi_range(1, 4)
		dir = 0
		await get_tree().create_timer(0.5).timeout
		if takingbreak == false:
			dir = prevdir
			$shootTimer.start()
			$Timer.start()

func death():
	dir = 0
	$Timer.stop()
	$shootTimer.stop()
	$AnimatedSprite2D.play("death")
	#$AudioStreamPlayer.play()
	await $AnimatedSprite2D.animation_finished
	self.queue_free()


func _on_timer_timeout():
	changedir()
	
func changedir():
	dir = randi_range(1, 4)
	


func _on_shoot_timer_timeout():
	
	num += 1
	$Timer.stop()
	prevdir = dir
	dir = 0
	
	if num == 6:
		$breakTimer.start()
		$Timer.stop()
		$shootTimer.stop()
		prevdir = dir
		if prevdir == 0:
			prevdir = randi_range(1, 4)
		dir = 0
		num = 0
	elif num % 2 == 1:
		get_node("AnimatedSprite2D").play("boulder attack forward")
		if Game.bossHP > 0:
			await get_node("AnimatedSprite2D").animation_finished
			var newKnife = Shoot.instantiate()
			newKnife.global_position = self.global_position
			newKnife.init(player.position.angle_to_point(self.position))
			get_parent().add_child(newKnife)
			get_node("AnimatedSprite2D").play("default")
			dir = prevdir
			$Timer.start()
			$shootTimer.start()
	elif num % 2 == 0:
		get_node("AnimatedSprite2D").play("ground_attack")
		if Game.bossHP > 0:
			await get_node("AnimatedSprite2D").animation_finished
			var newKnife = Quake.instantiate()
			newKnife.global_position = self.global_position
			#newKnife.init(player.position.angle_to_point(self.position))
			get_parent().add_child(newKnife)
			get_node("AnimatedSprite2D").play("default")
			dir = prevdir
			$Timer.start()
			$shootTimer.start()
	
	


func _on_visible_on_screen_notifier_2d_screen_entered():
	Game.boss = true
	process_mode = Node.PROCESS_MODE_INHERIT


func _on_visible_on_screen_notifier_2d_screen_exited():
	process_mode = Node.PROCESS_MODE_DISABLED

	

func _on_break_timer_timeout() -> void:
	dir = prevdir
	$shootTimer.start()
	$Timer.start()
