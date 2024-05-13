extends CanvasLayer

@onready var color_rect = $Color_Rect as ColorRect
@onready var level = $Color_Rect/LEVEL
@onready var clear = $Color_Rect/CLEAR

func _ready():
	color_rect.hide()
	show_new_scene()

func change_scene(path, delay = 0.5):
	color_rect.show()
	var scene_transition = get_tree().create_tween()
	scene_transition.tween_property(color_rect, "threshold", 5.0, 3.0).set_delay(delay)
	await get_tree().create_timer(1.15).timeout
	level.visible = true
	clear.visible = true
	await  scene_transition.finished
	Functions.load_screen_to_screen(path)

func show_new_scene():
	level.visible = false
	clear.visible = false
	var show_transition = get_tree().create_tween()
	show_transition.tween_property(color_rect, "threshold", 0.0, 0.5).from(1.0)
