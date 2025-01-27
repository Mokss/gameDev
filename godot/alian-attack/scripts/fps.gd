extends Label

func _process(_delta):
	# Получаем текущий FPS
	var fps = Engine.get_frames_per_second()
	
	# Обновляем текст Label
	text = "FPS: " + str(fps)
