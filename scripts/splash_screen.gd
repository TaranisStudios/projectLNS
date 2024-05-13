extends Control

@onready var anim = $Anim as AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(6).timeout
	anim.play("Fade_Out")
	await get_tree().create_timer(3).timeout
	Functions.load_screen_to_screen("res://scenes/world_select.tscn")
