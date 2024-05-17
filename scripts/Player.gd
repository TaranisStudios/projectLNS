extends CharacterBody2D


const NORMAL_SPEED = 675
const AIR_FRICTION := 0.5
const DASH_SPEED = 2800
const DASH_LENGTH = .1

@export var jump_height := 256
@export var max_time_to_peak := 0.5
@export var ghost_node : PackedScene

var jump_velocity
var gravity
var fall_gravity

var is_jumping := false
var is_hurted := false
var can_dash := true
var knockback_vector := Vector2.ZERO
var knockback_power := 20
var direction

var has_dashed_timeout = false

@onready var animation = $Anim as AnimatedSprite2D
@onready var animator = $Animator as AnimationPlayer
@onready var remote_transform = $Remote as RemoteTransform2D
@onready var dash = $Dash
@onready var level = $".."
@onready var particles = $Particles as GPUParticles2D

signal player_has_died()
signal player_has_lost_life()

func _ready():
	jump_velocity = (jump_height * 2) / max_time_to_peak
	gravity = (jump_height * 2) / pow(max_time_to_peak, 2)
	fall_gravity = gravity * 2
	
func _process(delta):
	if self.global_position.y > 1150:
		emit_signal("player_has_died")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_velocity
		is_jumping = true
	elif is_on_floor():
		is_jumping = false
	
	if velocity.y > 0 or not Input.is_action_pressed("Jump"):
		velocity.y += fall_gravity * delta
	else:
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("Dash") and can_dash:
		if Globals.player_max_dash > 0:
			Globals.player_max_dash -= 1
			particles.emitting = true
			await dash.start_dash(DASH_LENGTH)
			particles.emitting = false
			can_dash = false
			has_dashed_timeout = false
	elif !has_dashed_timeout:
		has_dashed_timeout = true
		await get_tree().create_timer(3).timeout
		Globals.player_max_dash = 1
		can_dash = true
		
	var SPEED
	if dash.is_dashing():
		SPEED = DASH_SPEED
		velocity.y = 0
	else:
		SPEED = NORMAL_SPEED
	
	direction = Input.get_axis("Left", "Right")
	
	if direction != 0:
		animation.scale.x = direction
		velocity.x = lerp(velocity.x, direction * SPEED, AIR_FRICTION)
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
	var knockback = Vector2((global_position.x - body.global_position.x) * knockback_power, -200)
	take_damage(knockback)

func Follow_Camera(camera):
	print(camera.global_position)
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func knockback(knockback_force := Vector2.ZERO, duration := 0.25):
	if knockback_force != Vector2.ZERO:		
			knockback_vector = knockback_force
		
			var knockback_tween = get_tree().create_tween()
			knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration).set
			animator.play("Hit_Flash")
	
			is_hurted = true
			await get_tree().create_timer(.3).timeout
			is_hurted = false

func take_damage(knockback_force := Vector2.ZERO):
	if Globals.player_hearts > 1:
		Globals.player_hearts -= 1
		knockback(knockback_force)
	else:
		await knockback(knockback_force)
		Globals.player_hearts -= 1
		queue_free()
		if Globals.player_life > 1:
			Globals.player_life -= 1
			emit_signal("player_has_lost_life")
		else:
			emit_signal("player_has_died")

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
