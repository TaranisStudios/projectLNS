extends Area2D

@onready var anim = $Anim as AnimatedSprite2D

var coins := 1

func _on_body_entered(body):
	anim.play("Collected")
	await $Collision.call_deferred("queue_free")
	Globals.coins += coins


func _on_anim_animation_finished():
	if anim.animation == "Collected":
		queue_free()
