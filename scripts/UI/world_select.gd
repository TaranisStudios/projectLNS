extends Control

@onready var player_icon = $Player_Icon
@onready var worlds: Array = [$World_Icon, $World_Icon2, $World_Icon3, $World_Icon4]

var current_world: int = 0

func _ready():
	player_icon.global_position = worlds[current_world].global_position

func _input(event):
	if event.is_action_pressed("Left") and current_world > 0:
		current_world -= 1
		player_icon.global_position = worlds[current_world].global_position
	if event.is_action_pressed("Right") and current_world < worlds.size() - 1:
		current_world += 1
		player_icon.global_position = worlds[current_world].global_position
	
	if event.is_action_pressed("ui_accept"):
		if worlds[current_world].level_select_scene:
			worlds[current_world].level_select_scene.parent_world_select = self
			get_tree().get_root().add_child(worlds[current_world].level_select_scene)
			get_tree().current_scene = worlds[current_world].level_select_scene
			get_tree().get_root().remove_child(self)
