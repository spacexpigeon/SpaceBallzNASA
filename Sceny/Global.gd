
extends Node


func load_screen_to_scene(scene_path: String, params: Dictionary = {}):
	var new_scene = load(scene_path)
	if new_scene:
		var instance = new_scene.instantiate()
		if params.has("test"):
			instance.test_param = params["test"]  
		get_tree().change_scene_to(instance)
	else:
		print("Nie można załadować sceny:", scene_path)
