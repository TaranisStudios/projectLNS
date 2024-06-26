extends Enemy

func _ready():
	wall_detector = $Wall_Detector
	score = 100
	anim.animation_finished.connect(kill_enemy_and_score)

func _physics_process(delta):
	_apply_gravity(delta)
	_movement(delta)
	_flip_direction()
