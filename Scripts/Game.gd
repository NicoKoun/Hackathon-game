extends Node

#INITIALIZE PLAYER HEALTH
var playerHP = 30
#INITIALIZE BOSS HEALTH
var bossHP = 30

#INITIALIZING TRUE/FALSE BOOLEAN STATEMENTS AT GAME START
#SET PLAYER DEATH TO FALSE
var dead = false
#SET CAMERA CHANGE/MOVE TO FALSE
var camchange = false
#SET PLAYER MOVEMENT TO TRUE
var canmove = true
#SET PLAYER GOT ITEM TO FALSE
var got = false
#SET SWORD TO TRUE
var sword = true
#SET BOSS TO FALSE
var boss = false
#position of player for checkpoint
var playerposition = Vector2(0,0)

#Score:
var coins = 0
