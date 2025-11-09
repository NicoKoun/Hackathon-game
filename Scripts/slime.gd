extends CharacterBody2D
#ADD SOUND EFFECTS
@onready var sfx_idle: AudioStreamPlayer = $sfx_idle
@onready var sfx_hurt: AudioStreamPlayer = $sfx_hurt

#const Star = preload("res://Star.tscn")
const SPEED = 30.0
var HP = 3
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dir = 0
#const EvilSlime = preload("res://evil_slime.tscn")
func _ready():
	$AnimatedSprite2D.play("default")
	changedir()

func _physics_process(delta):
	
	#movement script, dir is direction.
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
			sfx_hurt.play()
			Game.playerHP -= 3

func hurt():
	HP -= 1
	var tween: Tween = create_tween()
	if HP <= 0:
		death()
	else:
		tween.tween_property($AnimatedSprite2D, "modulate:v", 1, 0.25).from(15)
		$Timer.stop()
		var prevdir = dir
		dir = 0
		await get_tree().create_timer(0.5).timeout
		dir = prevdir
		$Timer.start()

func death():
	#var number = randi_range(1, 30)
	dir = 0
	sfx_idle.stop()
	sfx_hurt.stop()
	$Timer.stop()
	#gimmick of turing into another enemy upon death
	#if self.is_in_group("evil"):
		#$CollisionShape2D.queue_free()
		##get_node("player collision").queue_free()
		#$VisibleOnScreenNotifier2D.queue_free()
		#dir = 0
		#$AnimatedSprite2D.play("evildeath")
		#$AudioStreamPlayer2.play()
		#await $AnimatedSprite2D.animation_finished
		#var newEvil = EvilSlime.instantiate()
		#newEvil.global_position = self.global_position
		#var groups = get_groups()
		#for group in groups:
			#newEvil.add_to_group(group)
		#get_parent().add_child(newEvil)
	#else:
	$AnimatedSprite2D.play("death")
	$AudioStreamPlayer.play()
	await $AnimatedSprite2D.animation_finished
	#script to drop a health pickup
	#if number <= 6:
		#var newStar = Star.instantiate()
		#get_parent().add_child(newStar)
		#newStar.global_position = self.global_position
		#if number < 6:
			#newStar.init(1)
		#else:
			#newStar.init(5)
	self.queue_free()


func _on_timer_timeout():
	changedir()
	
func changedir():
	dir = randi_range(1, 4)
	


func _on_visible_on_screen_notifier_2d_screen_entered():
	process_mode = Node.PROCESS_MODE_INHERIT


func _on_visible_on_screen_notifier_2d_screen_exited():
	process_mode = Node.PROCESS_MODE_DISABLED
