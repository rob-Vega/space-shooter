extends Node2D


# 1. load scene
var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var star_scene: PackedScene = load("res://scenes/star.tscn")


func _ready() -> void:
	
	for n in 20:
		var star = star_scene.instantiate()
		$Stars.add_child(star)


func _on_meteor_timer_timeout() -> void:
	#2. create instance
	var meteor = meteor_scene.instantiate()
	
	#3. attach the node to the scene tree
	$Meteors.add_child(meteor)
	


func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	laser.position = pos
	$Lasers.add_child(laser)
