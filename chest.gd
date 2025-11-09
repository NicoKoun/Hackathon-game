extends CharacterBody2D


func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "player" and Input.is_action_just_pressed("Attack"):
		open()
			


func open():
	get_node("AnimatedSprite2D").play("Open")
	var num_coins = randi_range(5, 20)
	Game.coins += num_coins
	
