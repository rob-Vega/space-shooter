extends Area2D

signal collision

# Precargar texturas para mejorar rendimiento
var meteorsTextures: Array[Texture2D] = [
	preload("res://graphics/meteors/meteor_detailedLarge.png"),
	preload("res://graphics/meteors/meteor_squareLarge.png"),
]

var rng := RandomNumberGenerator.new()
var speed: int
var direction_x: float
var rotation_speed: float
var can_collide: bool = true

# Constantes
const SCREEN_BOTTOM = 780
const METEOR_MIN_SPEED = 200
const METEOR_MAX_SPEED = 300
const ROTATION_MIN_SPEED = 1
const ROTATION_MAX_SPEED = 5

@onready var meteor_sprite = $MeteorSprite
@onready var explosion_sound = $ExplosionSound


func _ready() -> void:
	# Asignar textura aleatoria
	meteor_sprite.texture = meteorsTextures[rng.randi_range(0, meteorsTextures.size() - 1)]
	
	# Posición inicial aleatoria
	var viewport_size = get_viewport().get_visible_rect().size
	position = Vector2(rng.randi_range(10, viewport_size.x - 10), rng.randi_range(-150, -100))
	
	# Velocidad, dirección y rotación aleatoria
	speed = rng.randi_range(METEOR_MIN_SPEED, METEOR_MAX_SPEED)
	direction_x = rng.randf_range(-0.5, 0.5)
	rotation_speed = rng.randf_range(ROTATION_MIN_SPEED, ROTATION_MAX_SPEED)


func _process(delta: float) -> void:
	# Movimiento y rotación del meteorito
	position += Vector2(direction_x, 1.0) * speed * delta
	rotate(rotation_speed * delta)
	
	# Eliminar el meteorito si sale de la pantalla
	if position.y > SCREEN_BOTTOM:
		queue_free()


func _on_body_entered(_body: Node2D) -> void:
	# Emitir señal y eliminar meteorito al colisionar con el jugador
	if can_collide:
		collision.emit()
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	# Deshabilitar colisiones y reproducir sonido al colisionar
	if can_collide:
		can_collide = false  # Desactivar colisiones
		area.queue_free()
		explosion_sound.play()
		meteor_sprite.visible = false
		
		await get_tree().create_timer(1).timeout
		queue_free()
