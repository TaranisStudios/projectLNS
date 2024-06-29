extends Enemy

const FIREBALL = preload("res://prefabs/Enemies/fireball.tscn")

@onready var player_detector = $Player_Detector as RayCast2D
@onready var animation = $Anima as AnimationPlayer
@onready var fireball_spawner = $Fireball_Spawner as Marker2D

enum Enemy_State {PATROL, ATTACK, HURT}
var current_state = Enemy_State.PATROL

@export var target : CharacterBody2D

func _ready():
	wall_detector = $Wall_Detector
	ground_detector = $Ground_Detector
	score = 50
	anim.animation_finished.connect(kill_enemy_and_score)

func _physics_process(delta):
	match(current_state):
		Enemy_State.PATROL : patrol_state(delta)
		Enemy_State.ATTACK : attack_state()

func patrol_state(delta):
	anim.play("Walk")
	_apply_gravity(delta)
	_flip_direction()	
	_movement(delta)
	
	if player_detector.is_colliding():
		_change_state(Enemy_State.ATTACK)

func attack_state():
	animation.play("Shooting")
	
	if !player_detector.is_colliding():
		_change_state(Enemy_State.PATROL)	
	
func hurt_state():
	anim.play("Hurt")

func _change_state(state):
	current_state = state

func spawn_fireball():
	var new_fireball = FIREBALL.instantiate()
	if sign(fireball_spawner.position.x) == 1:
		new_fireball.set_direction(1)
	else:
		new_fireball.set_direction(-1)
	add_sibling(new_fireball)
	new_fireball.global_position = fireball_spawner.global_position

func _on_hitbox_body_entered(body):
	_change_state(Enemy_State.HURT)
	hurt_state()
	
func _on_anim_animation_finished():
	if anim.name == "Hurt":
		queue_free()
