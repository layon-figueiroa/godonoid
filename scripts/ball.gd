extends CharacterBody2D

signal destroy_brick(brick)

#@onready var canvas_scene: CanvasLayer = $"../CanvasLayer"

var is_hold_active: bool = false
var attached_to_paddle: Node2D = null #Aqui define-se a que paddle a bola ficará presa
var offset: Vector2 #Aqui define-se o offset do paddle pra bola
var initial_position: Vector2 = Vector2(390.0, 516.0)

func _ready() -> void:
	velocity = Vector2.ZERO
	
	GameManager.life_lost.connect(_on_life_lost)
	GameManager.state_changed.connect(_on_state_changed)

func _physics_process(delta: float) -> void:
	check_out_of_game_area()
	
	if attached_to_paddle: #Quando houver um paddle definido
		position = attached_to_paddle.position + offset
		
		if Input.is_action_just_pressed("release"):
			release()
		return
		
	move_ball(delta)

func move_ball(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		handle_collision(collision)
		velocity = velocity.bounce(collision.get_normal())

func handle_collision(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	
	if is_hold_active and collider.is_in_group("paddle"):
		attach_to_paddle(collider)
		return
	
	if collider.is_in_group("brick"):
		destroy_brick.emit(collider)
		GameManager.add_score(10)
		print(GameManager.current_score)
		
func attach_to_paddle(paddle: Node2D) -> void:
	attached_to_paddle = paddle
	offset = Vector2(0, -20)
	velocity = Vector2.ZERO
	$Collision.disabled = true
	
func release() -> void:
	if attached_to_paddle:
		attached_to_paddle = null
		is_hold_active = false
		$Collision.disabled = false
		velocity = Vector2(200, -200)
		
func check_out_of_game_area() -> void:
	if position.y >= 600.0:
		GameManager.lose_life()
		
func reinitialize_move() -> void:
	velocity = Vector2(200, -200)
		
func _on_hold_active() -> void:
	is_hold_active = true
	
func _on_state_changed(new_state) -> void:
	if new_state != GameManager.State.PLAYING:
		_on_life_lost()
		return
	
	reinitialize_move()
	
func _on_life_lost() -> void:
	velocity = Vector2.ZERO
	position = initial_position
