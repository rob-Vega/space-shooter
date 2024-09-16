extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var window_size := get_viewport().get_visible_rect().size
	var star_pos_x = randf_range(10, window_size.x)
	var star_pos_y = randf_range(10, window_size.y)
	var rng_scale = randf_range(0.1, 1)
	
	position = Vector2(star_pos_x, star_pos_y)
	scale = Vector2(rng_scale, rng_scale)
	speed_scale = randf_range(1, 2)
