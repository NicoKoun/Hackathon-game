extends Node2D

const ENEMY = preload("res://Scenes/ememy.tscn")
var enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.camchange == true: #Game.awaiting == true and 
			Game.camchange = false
			get_node("ememy").queue_free()
			await get_tree().create_timer(0.1).timeout
			enemy = ENEMY.instantiate()
			enemy.global_position = self.global_position
			add_child(enemy, true,INTERNAL_MODE_BACK)
