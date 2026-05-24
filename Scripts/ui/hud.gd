extends CanvasLayer
class_name HUD

@onready var health_container = $MarginContainer/HBoxContainer/HealthSection/HealthContainer
@onready var coin_label = $MarginContainer/HBoxContainer/CoinSection/CoinRow/CoinLabel

var heart_icon = preload("res://Assets/items/ruby.png")

func _ready() -> void:
	pass

func update_health(current_health: int, max_health: int) -> void:
	if not health_container:
		return
		
	for child in health_container.get_children():
		child.queue_free()
		
	for i in range(max_health):
		var heart = TextureRect.new()
		heart.texture = heart_icon
		heart.custom_minimum_size = Vector2(24, 24)
		heart.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		heart.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		
		if i >= current_health:
			heart.modulate = Color(0.2, 0.2, 0.2, 0.5) 
		
		health_container.add_child(heart)

func update_coins(amount: int) -> void:
	if coin_label:
		coin_label.text = str(amount)
