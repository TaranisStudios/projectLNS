extends Node2D

@onready var player := $Player as CharacterBody2D

@onready var camera := $Camera as Camera2D
@onready var control = $HUD/Control
@onready var goal = $Goal

@onready var start_position = $Start_Position

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player_start_position = start_position
	GameManager.set_variables(player, camera)
	GameManager.player.Follow_Camera(camera)
	GameManager.player.player_has_lost_life.connect(GameManager.reload_game)
	GameManager.player.player_has_died.connect(GameManager.game_over)
	if control.time_is_up and !goal.has_reached_goal:
		GameManager.game_over()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

