extends CharacterBody2D

signal shoot_laser(pos: Vector2)
signal take_damage

const ROT_SPEED = 5
const SPEED = 500

var can_shoot := true
var player_health: int = 5

@onready var original_color: Color = $PlayerSprite.modulate
@onready var fire_sprite = $FireSprite
@onready var engine_sound = $EngineSound
@onready var laser_start_marker = $LaserStartMarker
@onready var laser_timer = $LaserTimer
@onready var laser_sound = $LaserSound


func _process(delta: float) -> void:
	handle_rotation(delta)
	handle_movement(delta)
	handle_shooting()


func handle_rotation(delta: float) -> void:
	var rot_direction = 0
	
	if Input.is_action_pressed("move_left"):
		rot_direction = -1
	elif Input.is_action_pressed("move_right"):
		rot_direction = 1

	rotation += rot_direction * ROT_SPEED * delta


func handle_movement(delta: float) -> void:
	velocity = Vector2()  # Reiniciar la velocidad

	if Input.is_action_pressed("move_up"):
		fire_sprite.visible = true
		engine_sound.play()
		velocity = Vector2(0, -SPEED).rotated(rotation)
	elif Input.is_action_pressed("move_down"):
		velocity = Vector2(0, SPEED / 2).rotated(rotation)
	else: 
		engine_sound.stop()
		fire_sprite.visible = false

	move_and_slide()


func handle_shooting() -> void:
	if Input.is_action_just_pressed("shoot_laser") and can_shoot:
		shoot_laser.emit(laser_start_marker.global_position)
		can_shoot = false
		laser_timer.start()
		laser_sound.play()


func _on_laser_timer_timeout() -> void:
	can_shoot = true


func change_sprite_color() -> void:
	$PlayerSprite.modulate = Color(1, 0, 0, 0.5)
	await get_tree().create_timer(0.2).timeout
	$PlayerSprite.modulate = original_color
