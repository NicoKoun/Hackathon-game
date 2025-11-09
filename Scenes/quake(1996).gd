extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.bossHP <= 0:
		self.queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("gamer"):
		if body.invince == false:
			body.gethurt()
			Game.playerHP -= 5
			queue_free()
