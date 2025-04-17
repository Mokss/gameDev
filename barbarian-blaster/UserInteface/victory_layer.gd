class_name VictoryLayer extends CanvasLayer

@onready var star_1: TextureRect = %Star1;
@onready var star_2: TextureRect = %Star2;
@onready var star_3: TextureRect = %Star3;
@onready var health_label: Label = $CenterContainer/PanelContainer/VBoxContainer/HealthLabel;
@onready var survived_label: Label = $CenterContainer/PanelContainer/VBoxContainer/SurvivedLabel;
@onready var money_label: Label = $CenterContainer/PanelContainer/VBoxContainer/MoneyLabel

@onready var base: Base = get_tree().get_first_node_in_group("base");
@onready var bank: Bank = get_tree().get_first_node_in_group("bank");

func victory() -> void:
	visible = true
	if base.max_health == base.current_healt:
		star_2.modulate = Color.WHITE
		health_label.visible = true
		if bank.gold >= 500:
			star_3.modulate = Color.WHITE
			money_label.visible = true
			


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
