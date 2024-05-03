extends EnemyBase

func _ready():
	wall_detector = $Wall_Detector
	texture = $Texture
	anim.animation_finished.connect(kill_groud_enemy)

func _physics_process(delta):
	_apply_gravity(delta)
	_movement(delta)
	_flip_direction()
