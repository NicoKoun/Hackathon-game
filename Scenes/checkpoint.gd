extends Area2D

var used = false
func _physics_process(delta: float) -> void:
	if Game.playerposition != self.get_position():
		used = false
		get_node("AnimatedSprite2D").play("Idle")
	
func _on_body_entered(body):
	if body.name == "player" && used == false:
		Game.playerHP += 10
		Game.playerposition = self.get_position()
		used = true
		get_node("AnimatedSprite2D").play("Raising")
		await get_node("AnimatedSprite2D").animation_finished
		get_node("AnimatedSprite2D").play("Raised")
