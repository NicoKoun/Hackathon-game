extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$ProgressBar.value = int(Game.playerHP)
	$BossBar.value = int(Game.bossHP)
	if Game.boss == true and Game.dead == false:
		$BossBar.show()
	else:
		$BossBar.hide()
	if Game.dead == true:
		$ProgressBar.hide()
	else:
		$ProgressBar.show()
		#$BossBar.max_value = 75
