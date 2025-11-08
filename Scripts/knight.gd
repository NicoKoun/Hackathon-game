extends CharacterBody2D

const Star = preload("res://Scenes/potions.tscn")
const SPEED = 125.0
const JUMP_VELOCITY = -400.0
var HP = 5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dir = 1
const Shoot = preload("res://Scenes/shoot pellet.tscn")
var player
var prevdir = 1
var angle
var timer = 0.0
var moving = false

func _ready():
	player = get_node("../../player/player")
	get_node("AnimatedSprite2D").play("Idle_Front")
	changedir()
	

func _physics_process(delta):

	if rad_to_deg(angle) > 90 or rad_to_deg(angle) < -90:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true
	if moving:
		velocity.x = SPEED * delta * cos(angle) * -1
		velocity.y = SPEED * delta * sin(angle) * -1
		if rad_to_deg(angle) > 0 and (HP > 0): 
			get_node("AnimatedSprite2D").play("Run_Back")
		elif (HP > 0):
			get_node("AnimatedSprite2D").play("Run_Front")
	else:
		velocity.x = 0
		velocity.y = 0
		if rad_to_deg(angle) > 0 and (HP > 0):
			get_node("AnimatedSprite2D").play("Idle_Back")
		elif (HP > 0):
			get_node("AnimatedSprite2D").play("Idle_Front")
		
	if(get_real_velocity() == Vector2(0,0)) and dir != 0:
		changedir()
	
	translate(velocity)
func _on_player_collision_body_entered(body):
	if body.name == "player":
		if body.invince == false:
			body.gethurt()
			Game.playerHP -= 5

func hurt():
	HP -= 1
	var tween: Tween = create_tween()
	if HP <= 0:
		death()
	else:
		tween.tween_property($AnimatedSprite2D, "modulate:v", 1, 0.25).from(15)
		$Timer.stop()
		$Movement.stop()
		var prevmove = moving
		moving = false
		await get_tree().create_timer(0.5).timeout
		if (HP > 0):
			moving = prevmove
			$Timer.start()
			$Movement.start()

func death():
	var number = randi_range(1, 30)
	$Timer.stop()
	#$shootTimer.stop()
	$AnimatedSprite2D.play("death")
	#$AudioStreamPlayer.play()
	await $AnimatedSprite2D.animation_finished
	if number <= 6:
		var newStar = Star.instantiate()
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
	angle = player.position.angle_to_point(self.position)
	



func _on_visible_on_screen_notifier_2d_screen_entered():
	process_mode = Node.PROCESS_MODE_INHERIT


func _on_visible_on_screen_notifier_2d_screen_exited():
	process_mode = Node.PROCESS_MODE_DISABLED


func _on_movement_timeout() -> void:
	if (HP > 0):
		moving = not moving
