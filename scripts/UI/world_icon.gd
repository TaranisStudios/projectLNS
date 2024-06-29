@tool
extends Control

@export var world_index: int = 1
@export var level_select_packed: PackedScene = load("res://UI/level_select.tscn")

@onready var level_select_scene: Level_Select = level_select_packed.instantiate()
@onready var label = $Label

func _ready():
	label.text = "World " + str(world_index)

func _process(delta):
	if Engine.is_editor_hint():
		label.text = "World "+ str(world_index)
