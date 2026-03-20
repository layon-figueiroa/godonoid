extends CanvasLayer

@export var texture_scene: PackedScene

@onready var hbox_container: HBoxContainer = $Control/VBoxContainer/HBoxContainer

func _ready() -> void:
	GameManager.life_lost.connect(_on_life_lost)
	
	generate_lives_panel()
	initialize_game()

func initialize_game() -> void:
	visible = true
	await get_tree().create_timer(6.0).timeout
	
	visible = false
	var paddle = get_tree().get_first_node_in_group("paddle")
	var ball = get_tree().get_first_node_in_group("ball")
	
	paddle.reinitialize_move()
	ball.reinitialize_move()
		
func generate_lives_panel() -> void:
	for child in hbox_container.get_children():
		child.queue_free()
	
	for i in range(GameManager.lives):
		var texture = texture_scene.instantiate()
		hbox_container.add_child(texture)

func _on_life_lost() -> void:
	generate_lives_panel()
	visible = true
	
	await get_tree().create_timer(6.0).timeout
	
	visible = false
	var paddle = get_tree().get_first_node_in_group("paddle")
	var ball = get_tree().get_first_node_in_group("ball")
	
	paddle.reinitialize_move()
	ball.reinitialize_move()
