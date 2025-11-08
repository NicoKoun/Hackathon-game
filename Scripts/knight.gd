extends CharacterBody2D


const SPEED = 80.0;

var dir = Vector2D(0, 0)

func hurt():
	

func _physics_process(delta):
	dir = 
	if followingPlayer:
		velocity.x = dir.x 

	move_and_slide()
