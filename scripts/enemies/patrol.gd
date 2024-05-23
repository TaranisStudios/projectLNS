extends Enemy

func _ready():
	score = 50
	anim.animation_finished.connect(kill_enemy_and_score)
	
func _physics_process(delta):
	_apply_gravity(delta)
	_movement(delta)
