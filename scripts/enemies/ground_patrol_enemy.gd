extends Enemy

func _ready():
	wall_detector = $Wall_Detector
	ground_detector = $Ground_Detector
	score = 50
	anim.animation_finished.connect(kill_enemy_and_score)

func _physics_process(delta):
	_apply_gravity(delta)
	_flip_direction()	
	_movement(delta)


