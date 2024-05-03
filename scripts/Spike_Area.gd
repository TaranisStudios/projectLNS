extends Area2D

@onready var texture = $Texture as Sprite2D
@onready var collision = $Collision as CollisionShape2D

@export var repeat_number = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	texture.region_rect = Rect2(0.0, 8.0, repeat_number, 8.0)
	collision.shape.size = texture.get_rect().size

func _on_body_entered(body):
	if body.name == "Player" && body.has_method("take_damage"):
		body.take_damage(Vector2(50, -250))
