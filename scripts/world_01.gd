extends Node2D

@onready var player := $Player as CharacterBody2D

@onready var player_scene = preload("res://actors/player.tscn")

@onready var camera := $Camera as Camera2D
@onready var control = $HUD/Control

@onready var start_position = $Start_Position

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.player_start_position = start_position
	Globals.player = player
	set_variables()
	Globals.player.Follow_Camera(camera)
	Globals.player.player_has_lost_life.connect(reload_game)
	Globals.player.player_has_died.connect(game_over)
	control.time_is_up.connect(game_over)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reload_game():
	await get_tree().create_timer(1.0).timeout
	var player = player_scene.instantiate()
	add_child(player)
	#control.reset_clock_timer()
	Globals.player = player
	Globals.player.Follow_Camera(camera)
	set_variables()
	Globals.player.player_has_lost_life.connect(reload_game)
	Globals.player.player_has_died.connect(game_over)
	Globals.respawn_player()

func set_variables():
	Globals.coins = 0
	Globals.score = 0
	Globals.player_hearts = 3
	#Globals.player_life = 3

func game_over():
	if control.time_is_up:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	elif Globals.player_life > 1:
		reload_game()
