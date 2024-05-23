extends Node

signal level_beaten()

@onready var player_scene = preload("res://actors/player.tscn")

var player = null
var camera : Camera2D

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

func reload_game():
	player = player_scene.instantiate()
	add_child(player)
	set_variables(player, camera)
	player.Follow_Camera(camera)
	player.player_has_lost_life.connect(reload_game)
	player.player_has_died.connect(game_over)
	respawn_player()

func set_variables(p : Player, c : Camera2D):
	player = p
	camera = c
	coins = 0
	score = 0
	player_hearts = 3

func game_over():
	player_life = 3
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
