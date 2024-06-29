extends Area2D

@onready var anim = $Anim as AnimatedSprite2D
@onready var marker = $Marker as Marker2D

var is_active = false

func _on_body_entered(body):
	if body.name != "Player" or is_active:
		return
	activate_checkpoint()
	
func activate_checkpoint():
	anim.play("Raising")
	is_active = true

func _on_anim_animation_finished():
	if anim.animation == "Raising":
		GameManager.current_checkpoint = marker
		anim.play("Checked")
		
