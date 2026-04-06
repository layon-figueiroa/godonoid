extends CharacterBody2D

@export var speed: float

@onready var collision: CollisionShape2D = $Collision

var initial_position: Vector2 = Vector2(286.0, 551.0)

func _ready() -> void:
	GameManager.life_lost.connect(_on_life_lost)
	GameManager.state_changed.connect(_on_state_changed)

func _physics_process(_delta: float) -> void:
	move_paddle()
	
	move_and_slide()

func move_paddle() -> void:
	var dir: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * speed
	velocity.y = 0

func increase_speed() -> void:
	speed = 600.0
	await get_tree().create_timer(10.0).timeout
	
	if speed == 600.0:
		speed = 300.0

func add_score() -> void:
	GameManager.add_score(1000)
	
func growth_paddle() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "scale:x", 2.0, 0.4)
	
	await get_tree().create_timer(20.0).timeout
	
	var tween_back = create_tween()
	tween_back.set_trans(Tween.TRANS_SINE)
	tween_back.set_ease(Tween.EASE_IN_OUT)
	
	tween_back.tween_property(self, "scale:x", 1.0, 0.4)
	
func reinitialize_move() -> void:
	speed = 300.0
	
func reset_bonus() -> void:
	scale.x = 1.0
	speed = 300.0

func _on_bonus_collected(effect) -> void:
	match effect:
		"speed":
			increase_speed()
		"score":
			add_score()
		"hold":
			var ball = get_tree().get_first_node_in_group("ball")
			ball._on_hold_active()
		"growth":
			growth_paddle()

func _on_life_lost() -> void:
	speed = 0
	position = initial_position
	
func _on_state_changed(new_state) -> void:
	match new_state:
		GameManager.State.START:
			_on_life_lost()
			reset_bonus()
			collision.disabled = true
			print("O paddle está paradinho")
		GameManager.State.STAND_BY:
			_on_life_lost()
			reset_bonus()
			collision.disabled = true
			print("O paddle está paradinho")
		GameManager.State.PLAYING:
			reinitialize_move()
			collision.disabled = false
			print("O paddle está se movendo")
		GameManager.State.PAUSED:
			return
		GameManager.State.GAME_OVER:
			_on_life_lost()
			reset_bonus()
			collision.disabled = true
			print("O paddle está paradinho")
