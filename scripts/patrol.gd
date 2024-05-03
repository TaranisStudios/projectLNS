extends EnemyBase

func _ready():
	anim.animation_finished.connect(kill_patrol_enemy)
	
func _physics_process(delta):
	_apply_gravity(delta)
	_movement(delta)
