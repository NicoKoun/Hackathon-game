extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_pressed():
	Game.playerHP = 30
	Game.bossHP = 30
	Game.dead = false
	Game.camchange = false
	Game.canmove = true
	Game.got = false
	Game.sword = true
	Game.boss = false
	Game.coins = 0
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	

func _on_quit_pressed():
	get_tree().quit(0)
