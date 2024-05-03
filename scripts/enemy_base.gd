extends CharacterBody2D
class_name EnemyBase

const SPEED = 2500.0
const JUMP_VELOCITY = -400.0

@onready var anim := $Anim

@export var enemy_value = 100

var wall_detector
var texture
var direction := -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_spawn = false
var spawn_instance : PackedScene = null
var spawn_instance_position

func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func _movement(delta):
	if is_on_floor():
		velocity.x = direction * SPEED * delta
	move_and_slide()

func _flip_direction():
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false

func kill_groud_enemy(anim_name: StringName) -> void:
	kill_and_score()
	
func kill_patrol_enemy():
	kill_and_score()

func kill_and_score():
	Globals.score += enemy_value
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
