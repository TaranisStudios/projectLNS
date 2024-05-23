extends Enemy

@onready var spawn_enemy = $Spawn_Enemy as Marker2D

func _ready():
	score = 100
	spawn_instance = preload("res://actors/patrol.tscn")
	spawn_instance_position = spawn_enemy
	can_spawn = true
	anim.animation_finished.connect(kill_enemy_and_score)
