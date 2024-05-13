extends Control
class_name Level_Select

@onready var current_level: Level_Icon = $Level_Icon
@onready var player_icon = $Player_Icon

var parent_world_select: Node

func _ready():
	player_icon.global_position = current_level.global_position

func _input(event):
	if event.is_action_pressed("Left") and current_level.next_level_left:
		current_level = current_level.next_level_left
		player_icon.global_position = current_level.global_position
	if event.is_action_pressed("Up") and current_level.next_level_up:
		current_level = current_level.next_level_up
		player_icon.global_position = current_level.global_position
	if event.is_action_pressed("Right") and current_level.next_level_right:
		current_level = current_level.next_level_right
		player_icon.global_position = current_level.global_position
	if event.is_action_pressed("Down") and current_level.next_level_down:
		current_level = current_level.next_level_down
		player_icon.global_position = current_level.global_position 
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().get_root().add_child(parent_world_select)
		get_tree().current_scene = parent_world_select
		get_tree().get_root().remove_child(self)
	
	if event.is_action_pressed("ui_accept"):
		if current_level.next_scene_path:
			Functions.load_screen_to_screen(current_level.next_scene_path)
