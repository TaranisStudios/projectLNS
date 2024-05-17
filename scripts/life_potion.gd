extends Area2D

@onready var texture = $Texture as AnimatedSprite2D

func _on_body_entered(body):
	if Globals.player_life < 3:
		texture.scale = texture.scale * 3.5
		texture.play("Collected")
		await $Collision.call_deferred("queue_free")
		Globals.player_life += 1
		


func _on_texture_animation_finished():
	if texture.animation == "Collected":
		queue_free()
