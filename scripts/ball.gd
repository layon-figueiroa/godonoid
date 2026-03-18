extends CharacterBody2D

signal destroy_brick(brick)

func _ready() -> void:
	velocity = Vector2(100, -100)

func _physics_process(delta: float) -> void:
	move_ball(delta)

func move_ball(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		handle_collision(collision)
		velocity = velocity.bounce(collision.get_normal())

func handle_collision(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	
	if collider.is_in_group("brick"):
		destroy_brick.emit(collider)
		GameManager.add_score(10)
