extends Node

var player = null

#HUD vars
var coins := 0
var score := 0
var player_max_hearts: int = 3
var player_hearts: int = 3
var player_life: int = 3
var player_max_dash: int = 1

var player_start_position = null

func respawn_player():
	player.global_position = player_start_position.global_position
