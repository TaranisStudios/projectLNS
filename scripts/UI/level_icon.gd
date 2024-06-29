@tool
extends Control
class_name Level_Icon

@onready var label = $Label as Label

@export var level_name := 1
@export_file("*.tscn") var next_scene_path: String
@export var next_level_up: Level_Icon
@export var next_level_down: Level_Icon
@export var next_level_left: Level_Icon
@export var next_level_right: Level_Icon

func _ready():
	label.text = "Level " + str(level_name)

func _process(delta):
	if Engine.is_editor_hint():
		label.text = "Level " + str(level_name)
