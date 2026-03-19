extends CharacterBody2D

signal destroy_brick(brick)

var is_hold_active: bool = false
var attached_to_paddle: Node2D = null #Aqui define-se a que paddle a bola ficará presa
var offset: Vector2 #Aqui define-se o offset do paddle pra bola

func _ready() -> void:
	velocity = Vector2(100, -100)

func _physics_process(delta: float) -> void:
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
		velocity = Vector2(100, -100)
		
func _on_hold_active() -> void:
	is_hold_active = true
