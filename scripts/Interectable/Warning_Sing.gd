extends Node2D

@onready var texture = $Texture
@onready var area_sign = $Area_Sign

const lines : Array[String] = [
	"E ai Zé Ruela.",
	"Finalmente levantou...",
	"É bom já ter pegado tudo que precisava...",
	"porque a cobra...",
	"JÁ TA FUMANDO!!!"
]

func _unhandled_input(event):
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			texture.hide()
			DialogManager.start_message(global_position, lines)
	else:
		texture.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active =false
