extends CanvasLayer

@onready var selection_wheel = $Selection_Wheel

func _process(delta):
	if Input.is_action_just_pressed("selection_wheel"):
		selection_wheel.show()
		get_tree().paused = true
	elif Input.is_action_just_released("selection_wheel"):
		selection_wheel.hide()
		get_tree().paused = false
