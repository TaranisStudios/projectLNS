extends Area2D

@onready var texture = $Texture as AnimatedSprite2D

func _on_body_entered(body):
	if GameManager.player_hearts < 3:
		texture.scale = texture.scale * 3.5
		texture.play("Collected")
		await $Collision.call_deferred("queue_free")
		GameManager.player_hearts += 1
		
func _on_texture_animation_finished():
	if texture.animation == "Collected":
		queue_free()
