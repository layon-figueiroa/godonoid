extends Control

@onready var top_score: Label = $VBoxContainer/MarginHighScore/ContHighScore/HighScore
@onready var score: Label = $VBoxContainer/MarginScore/ContScore/Score
@onready var lives_container: HBoxContainer = $VBoxContainer/MarginLives/ContLives

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	
func _process(_delta: float) -> void:
	update_scores()

func update_scores() -> void:
	top_score.text = str(GameManager.top_score)
	score.text = str(GameManager.current_score)
	
func generate_lives_panel() -> void:
	for i in range(GameManager.lives):
		var texture_scene = preload("res://scenes/life_texture.tscn")
		var texture = texture_scene.instantiate()
		lives_container.add_child(texture)
		
func update_lives() -> void:
	for child in lives_container.get_children():
		child.queue_free()
	
	generate_lives_panel()
	
func _on_state_changed(new_state) -> void:
	'''if new_state != GameManager.State.PLAYING:
		visible = false
		return'''
	if (
		new_state == GameManager.State.STAND_BY or 
		new_state == GameManager.State.GAME_OVER or
		new_state == GameManager.State.START):
		visible = false
		return
	
	update_lives()
	visible = true
