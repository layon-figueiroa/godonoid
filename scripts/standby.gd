extends Control

@onready var hbox_container: HBoxContainer = $VBoxContainer/HBoxContainer

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	
func generate_lives_panel() -> void:
	for i in range(GameManager.lives):
		var texture_scene = preload("res://scenes/life_texture.tscn")
		var texture = texture_scene.instantiate()
		hbox_container.add_child(texture)
		
func life_lost() -> void:
	for child in hbox_container.get_children():
		child.queue_free()
	
	generate_lives_panel()
		
func show_stand_by() -> void:
	life_lost()
	visible = true
	
	await get_tree().create_timer(6.0).timeout
	
	visible = false
	GameManager.change_state(GameManager.State.PLAYING)
	
func _on_state_changed(new_state) -> void:
	if new_state != GameManager.State.STAND_BY:
		return
	
	show_stand_by()
