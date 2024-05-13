extends Panel

@onready var texture = $Texture

func update(whole: bool):
	if whole: texture.frame = 0
	else: texture.frame = 1
