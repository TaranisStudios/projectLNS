extends Area2D
class_name Coin

@onready var anim = $Anim as AnimatedSprite2D

@export var coins := 1
@export var score = 10

func _on_body_entered(body):
	anim.play("Collected")
	await $Collision.call_deferred("queue_free")
	GameManager.score += score
	GameManager.coins += coins


func _on_anim_animation_finished():
	if anim.animation == "Collected":
		queue_free()
