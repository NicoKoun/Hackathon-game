extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#SET HEALTH BAR VALUE TO PLAYERS HEALTH
	$ProgressBar.value = int(Game.playerHP)
	#SET HEALTH BAR VALUE TO BOSSES HEALTH
	$BossBar.value = int(Game.bossHP)
	#SHOW BOSS HEALTH BAR AS LONG AS THE BOSS AND PLAYER ARE ALIVE
	if Game.boss == true and Game.dead == false:
		$BossBar.show()
	else:
		$BossBar.hide()
	if Game.dead == true:
		$ProgressBar.hide()
	else:
		$ProgressBar.show()
		#$BossBar.max_value = 75
