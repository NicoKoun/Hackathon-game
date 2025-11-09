extends CharacterBody2D

const potion = preload("res://Scenes/potions.tscn")
const SPEED = 80.0
const JUMP_VELOCITY = -400.0
var HP = 5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dir = 1
#Change this to a rock
const Shoot = preload("res://Scenes/shoot pellet.tscn")
#Also add quake attack.
var player
var prevdir = 1
func _ready():
	#add audio stream player
	player = get_node("../../player/player")
	get_node("AnimatedSprite2D").play("default")
	

func _physics_process(delta):
	if dir == 0:
		velocity.x = 0
		velocity.y = 0
	elif dir == 1:
		velocity.x = SPEED
		velocity.y = 0
	elif dir == 2:
		velocity.x = SPEED * -1
		velocity.y = 0
	elif dir == 3:
		velocity.x = 0
		velocity.y = SPEED
	elif dir == 4:
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
	HP -= 1
	var tween: Tween = create_tween()
	if HP <= 0:
		death()
	else:
		tween.tween_property($AnimatedSprite2D, "modulate:v", 1, 0.25).from(15)
		$Timer.stop()
		$shootTimer.stop()
		var prevdir = dir
		if prevdir == 0:
			prevdir = randi_range(1, 4)
		dir = 0
		await get_tree().create_timer(0.5).timeout
		dir = prevdir
		$shootTimer.start()
		$Timer.start()

func death():
	var number = randi_range(1, 30)
	dir = 0
	$Timer.stop()
	$shootTimer.stop()
	$AnimatedSprite2D.play("death")
	#$AudioStreamPlayer.play()
	await $AnimatedSprite2D.animation_finished
	if number <= 6:
		var newStar = potion.instantiate()
		get_parent().add_child(newStar)
		newStar.global_position = self.global_position
		if number < 6:
			newStar.init(1)
		else:
			newStar.init(5)
	self.queue_free()


func _on_timer_timeout():
	changedir()
	
func changedir():
	dir = randi_range(1, 4)
	


func _on_shoot_timer_timeout():
	$Timer.stop()
	prevdir = dir
	dir = 0
	get_node("AnimatedSprite2D").play("attack")
	if HP > 0:
		await get_node("AnimatedSprite2D").animation_finished
		var newKnife = Shoot.instantiate()
		newKnife.global_position = self.global_position
		#newKnife.init(player.position.angle_to_point(self.position))
		get_parent().add_child(newKnife)
		get_node("AnimatedSprite2D").play("default")
		dir = prevdir
		$Timer.start()


func _on_visible_on_screen_notifier_2d_screen_entered():
	process_mode = Node.PROCESS_MODE_INHERIT


func _on_visible_on_screen_notifier_2d_screen_exited():
	process_mode = Node.PROCESS_MODE_DISABLED
