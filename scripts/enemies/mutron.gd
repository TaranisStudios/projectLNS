extends Enemy

func _movement(delta):
	if anim.animation == "Hurt":
		velocity.x = 0
	elif is_on_floor():
		velocity.x = direction * SPEED*0.25 * delta
	move_and_slide()
	
# Aplica fisica de gravidade, movimento e flip ao detectar wall
func _physics_process(delta):
	_apply_gravity(delta)
	_movement(delta)
	_flip_direction()
	if player_detector.is_colliding():
		attack(1)
	

func _ready():
	score = 50
	wall_detector = $Wall_Detector
	player_detector = $Player_Detector

