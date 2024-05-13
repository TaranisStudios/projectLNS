extends Node

var player = null

#HUD vars
var coins := 0
var score := 0
var player_max_hearts: int = 3
var player_hearts: int = 3
var player_life := 3
#

#Checkpoint system
var current_checkpoint = null
var player_start_position = null

func respawn_player():
	if current_checkpoint != null:
		player.global_position = current_checkpoint.global_position
	else:
		player.global_position = player_start_position.global_position
