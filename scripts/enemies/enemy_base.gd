extends CharacterBody2D
class_name Enemy

const SPEED = 5500.0
const JUMP_VELOCITY = -400.0

@onready var anim := $Anim

@export var score := 0

var wall_detector
var ground_detector
var direction := -1
var facing_right = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_spawn = false
var spawn_instance : PackedScene = null
var spawn_instance_position

func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func _movement(delta):
	if anim.animation == "Hurt":
		velocity.x = 0
	elif is_on_floor():
		velocity.x = direction * SPEED * delta
	move_and_slide()

func _flip_direction():	
	if wall_detector.is_colliding() or ground_detector != null and !ground_detector.is_colliding():
		scale.x = abs(scale.x) * -1
		direction *= -1


func kill_enemy_and_score():
	GameManager.score += score
	if can_spawn:
		spawn_new_enemy()
		get_parent().queue_free()
	else:
		queue_free()

func spawn_new_enemy():
	var instace_scene = spawn_instance.instantiate()
	get_tree().root.add_child(instace_scene)
	instace_scene.global_position = spawn_instance_position.global_position

func _on_hitbox_body_entered(body):
	anim.play("Hurt")
