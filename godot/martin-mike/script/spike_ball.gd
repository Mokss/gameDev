extends CharacterBody2D

signal touched_player

@export var speed: float = 100.0  # Скорость движения
@export var move_distance: float = 100.0  # Максимальное расстояние в одну сторону

var start_position: Vector2  # Запоминаем начальную позицию
var direction: int = 1  # 1 = вправо, -1 = влево

func _ready():
	start_position = position  # Сохраняем начальную позицию

func _physics_process(_delta):
	velocity.x = speed * direction
	move_and_slide()

	# Проверяем, врезался ли в стену
	if is_on_wall():
		direction *= -1  # Меняем направление

	# Проверяем, не превысило ли расстояние 100px от начальной точки
	if abs(position.x - start_position.x) >= move_distance:
		direction *= -1  # Меняем направление

func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		touched_player.emit()
