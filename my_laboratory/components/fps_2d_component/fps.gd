extends Label

@onready var fps_label: Label = $"."

const FPS_STRING: String = "FPS: "

func _process(_delta: float) -> void:
	fps_label.text = FPS_STRING + str(int(Engine.get_frames_per_second()))
