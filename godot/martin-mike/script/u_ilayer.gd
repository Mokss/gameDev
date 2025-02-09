class_name UILayer extends CanvasLayer

func show_win_screen(flag: bool) -> void:
	print("test flaga:", flag)
	$WinScreen.visible = flag
