extends CharacterBody2D

var player_in_range = false
var is_open = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_in_range = true

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_in_range = false
		
func _process(delta):
	if is_open and player_in_range and Input.is_action_just_pressed("Attack"):
		open()

func open():
	get_node("AnimatedSprite2D").play("Open")
	var num_coins = randi_range(5, 20)
	Game.coins += num_coins
	is_open = true
	
