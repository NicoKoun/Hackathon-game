extends CharacterBody2D



func _on_player_detection_body_entered(body: Node2D) -> void:
	if body == "player":
