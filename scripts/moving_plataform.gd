extends Node2D

const WAIT_DURATION := 1.0

@onready var plataform := $Plataform as AnimatableBody2D
@export var move_speed := 3.0
@export var distance := 192
@export var move_horizontal := true
@export var invert_direction := false

var follow := Vector2.ZERO
var plataform_center := 16
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	move_plataform()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	plataform.position = plataform.position.lerp(follow, 0.5)

func move_plataform():
	
	if(!invert_direction):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
	
	var move_direction = direction * distance if move_horizontal else Vector2.UP * distance
	var durantion = move_direction.length() / float(move_speed * plataform_center)
	
	var plataform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	plataform_tween.tween_property(self, "follow", move_direction, durantion).set_delay(WAIT_DURATION)
	plataform_tween.tween_property(self, "follow", Vector2.ZERO, durantion).set_delay(durantion + WAIT_DURATION / 2)
