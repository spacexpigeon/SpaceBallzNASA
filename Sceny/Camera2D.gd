extends Camera2D


func _ready():
	adjust_camera_size()


func adjust_camera_size():
	var screen_size = OS.window_size  
	var base_resolution = Vector2(1280, 720) 
	var scale_factor = base_resolution / screen_size  

	
	zoom = scale_factor 


func _notification(what):
	if what == NOTIFICATION_RESIZED:
		adjust_camera_size()  
