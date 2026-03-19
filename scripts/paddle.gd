extends CharacterBody2D

@export var speed: float = 300.0

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
	scale = Vector2(2.0, 1.0)
	await get_tree().create_timer(20.0).timeout
	
	if scale.x == 2.0:
		scale = Vector2(1.0, 1.0)

func _on_bonus_collected(effect) -> void:
	match effect:
		"speed":
			increase_speed()
		"score":
			add_score()
			print(GameManager.current_score)
		"hold":
			var ball = get_tree().get_first_node_in_group("ball")
			ball._on_hold_active()
		"growth":
			growth_paddle()
