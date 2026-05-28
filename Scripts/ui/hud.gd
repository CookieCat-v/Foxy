extends CanvasLayer
class_name HUD

@onready var health_bar = $MarginContainer/HBoxContainer/HealthSection/HealthBar
@onready var coin_label = $MarginContainer/HBoxContainer/CoinSection/CoinRow/CoinLabel

func _ready() -> void:
	pass

func update_health(current_health: int, max_health: int) -> void:
	if not health_bar:
		return
		
	health_bar.max_value = max_health
	health_bar.value = current_health

func update_coins(amount: int) -> void:
	if coin_label:
		coin_label.text = str(amount)
