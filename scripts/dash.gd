extends Node

@onready var dash_timer = $Dash_Timer

@export var anim : AnimatedSprite2D
@export var ghost_node : PackedScene

func start_dash(duration):
	dash_timer.wait_time = duration
	dash_timer.start()
	while !dash_timer.is_stopped():
		await get_tree().create_timer(0.05).timeout
		add_ghost()

func is_dashing():
	return !dash_timer.is_stopped()

func add_ghost():
	var ghost = ghost_node.instantiate()
	ghost.set_property(get_parent().position, anim.scale)
	get_tree().current_scene.add_child(ghost)

