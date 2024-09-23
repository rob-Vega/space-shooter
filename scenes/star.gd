extends AnimatedSprite2D

func _ready() -> void:
	var window_size = get_viewport().get_visible_rect().size
	var random_scale = randf_range(0.1, 1)
	position = Vector2(randf_range(10, window_size.x), randf_range(10, window_size.y))
	scale = Vector2(random_scale, random_scale)  # Aplicar la misma escala a ambos ejes
	speed_scale = randf_range(1, 2)
