extends Area2D

var used = false
func _physics_process(delta: float) -> void:
	if Game.playerHP != self.get_position():
		used = false
		get_node("AnimatedSprite2D").frame = 0
	
func _on_body_entered(body):
	if body.name == "player" && used == false:
		get_node("AnimatedSprite2D").play("default")
		Game.playerHP += 10
		Game.playerposition = self.get_position()
		used = true
