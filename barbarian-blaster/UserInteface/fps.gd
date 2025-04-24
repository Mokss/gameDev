extends Label

@export var onVsync: bool = true

func _ready() -> void:
	if onVsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _process(_delta: float) -> void:
	text = "FPS: " + str(Engine.get_frames_per_second())
