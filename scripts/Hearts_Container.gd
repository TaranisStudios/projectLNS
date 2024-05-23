extends HBoxContainer

@onready var heartUI = preload("res://UI/hearts.tscn")

func _ready():
	set_max_hearts()

func _process(delta):
	update_heart(GameManager.player_hearts)

func set_max_hearts():
	for i in range(GameManager.player_max_hearts):
		var heart = heartUI.instantiate()
		add_child(heart)	


func update_heart(current_health : int):
	var hearts = get_children()
	
	for i in range(current_health):
		hearts[i].update(true)
	
	for i in range(current_health, hearts.size()):
		hearts[i].update(false)
