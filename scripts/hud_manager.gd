extends Control

@onready var life_counter = $MarginContainer/Left_Container/VBoxContainer/Life_Container/Life_Counter
@onready var timer_counter = $MarginContainer/Mid_Container/Timer_Counter
@onready var score_counter = $MarginContainer/Right_Container/VBoxContainer/Score_Counter
@onready var coins_counter = $MarginContainer/Right_Container/VBoxContainer/Coins_Container/Coins_Counter
@onready var clock_timer = $Clock_Timer as Timer

@export_range(0, 5) var default_minutes := 0
@export_range(0, 59) var default_seconds := 10

var minutes = 0
var seconds = 0

var time_is_up = false

# Called when the node enters the scene tree for the first time.
func _ready():
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_life)
	timer_counter.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)
	minutes = default_minutes
	seconds = default_seconds


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_life)
	
	if minutes == 0 and seconds == 0:
		time_is_up = true


func _on_clock_timer_timeout():
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1
	
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)
