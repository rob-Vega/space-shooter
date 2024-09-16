extends CharacterBody2D


@export var speed := 500
var can_shoot := true
signal laser(pos: Vector2)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(200, 500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction.y < 0:
		$FireSprite.visible = true
	else:
		$FireSprite.visible = false
	
	velocity = direction * speed
	move_and_slide()
	
	# shoot input
	if Input.is_action_just_pressed("shoot_laser") and can_shoot:
		laser.emit($LaserStartMarker.global_position)
		can_shoot = false
		$LaserTimer.start()


func _on_laser_timer_timeout() -> void:
	can_shoot = true
