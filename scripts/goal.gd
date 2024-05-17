extends Area2D

@onready var transition = $"../Transition"

@export var next_level : String = ""

var has_reached_goal = false

func _on_body_entered(body):
	if body.name == "Player" and !next_level == "": 
		has_reached_goal = true
		transition.change_scene(next_level)
	else:
		return
