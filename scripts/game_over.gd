extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_btn_pressed():
	Functions.load_screen_to_screen("res://levels/level_01.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()
