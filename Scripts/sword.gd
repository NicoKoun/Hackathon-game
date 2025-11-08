extends Area2D
var dirright = false
var ogposition
# Called when the node enters the scene tree for the first time.
func init(direction):
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.visible = true
	ogposition = self.position
	if direction == "down":
		self.rotation = PI
		self.position.x += 6
		get_node("AnimatedSprite2D").play("Vertical")
	elif direction == "right":
		self.rotation = PI/2
		#self.position.y += 9
		self.position.x -= 2
		#$CollisionShape2D.position.x -= 6
		#dirright = true
		get_node("AnimatedSprite2D").play("Side")
	elif direction == "left":
		self.rotation = PI*3/2
		#self.position.y += 9
		self.position.x += 2
		get_node("AnimatedSprite2D").play("Side")
	else:
		self.rotation = 0
		self.position.x += 6
		self.position.y += 6
		get_node("AnimatedSprite2D").play("Vertical")
	

func _process(delta):
	if Input.is_action_just_pressed("Attack") and get_node("AnimatedSprite2D").is_playing():
		get_node("CollisionShape2D").disabled = false

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("enemy"):
		body.hurt()
		get_node("CollisionShape2D").disabled = true


func _on_animated_sprite_2d_animation_finished():
	Game.canmove = true
	Game.sword = true
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.visible = false
	get_parent().Attack = false
	position = ogposition
	#if dirright == true:
		#$CollisionShape2D.position.x += 6
		#dirright = false
	#queue_free()
	
