extends Node2D

func _ready():
	$AnimationPlayer.play("Fade")  
	await get_tree().create_timer(3).timeout  
	$AnimationPlayer.play("Fade out")  
	await get_tree().create_timer(6).timeout  
	get_tree().change_scene_to_file("res://Sceny/Main.tscn")
