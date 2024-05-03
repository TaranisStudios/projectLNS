extends CharacterBody2D


const SPEED = 150.0
const JUMP_FORCE = -350

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var is_hurted := false
var knockback_vector := Vector2.ZERO
var direction

@onready var animation = $Anim as AnimatedSprite2D
@onready var animator = $Animator as AnimationPlayer
@onready var remote_transform = $Remote as RemoteTransform2D

signal player_has_died()

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	
	elif is_on_floor():
		is_jumping = false

	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		animation.scale.x = direction
		velocity.x = direction * SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector 
	
	_set_state()
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)


func _on_hurtbox_body_entered(body):
	if $Ray_Right.is_colliding():
		take_damage(Vector2(-200, -200))
	
	elif $Ray_Left.is_colliding():
		take_damage(Vector2(200, -200))

func Follow_Camera(camera):
		var camera_path = camera.get_path()
		remote_transform.remote_path = camera_path
	

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	if Globals.player_life > 0:
		Globals.player_life -= 1
	else:
		queue_free()
		emit_signal("player_has_died")
	
	if knockback_force != Vector2.ZERO:		
		knockback_vector = knockback_force
		
		var knockback_tween = get_tree().create_tween()
		
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration).set
		
		animator.play("Hit_Flash")
	
	is_hurted = true
	await get_tree().create_timer(.3).timeout
	is_hurted = false
	
func _set_state():
	var state = "Idle"
	
	if is_hurted:
		state = "Hurt"
	elif !is_on_floor():
		state = "Jump"
	elif direction != 0:
		state = "Run"
	
		
	if animation.name != state:
		animation.play(state)


func _on_head_collider_body_entered(body):
	if body.has_method("break_sprite"):
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.break_sprite()
		else:
			body.animation_player.play("Hit")
			body.create_coin()
