extends Area2D


@export var speed = 1000
var direction: Vector2


func _ready() -> void:
	$Sprite2D.scale = Vector2(0, 0)
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(0.25, 0.65), 0.2)


func _physics_process(delta: float) -> void:
	direction = Vector2(0, -1).rotated(rotation)
	position += direction * speed * delta
