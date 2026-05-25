extends Control
class_name SettingsMenu

@onready var master_slider = $PopupBackground/VBoxContainer/MasterRow/MasterSlider
@onready var bgm_slider = $PopupBackground/VBoxContainer/BGMRow/BGMSlider
@onready var sfx_slider = $PopupBackground/VBoxContainer/SFXRow/SFXSlider
@onready var close_btn = $PopupBackground/CloseBtn

var master_bus_idx = AudioServer.get_bus_index("Master")
var bgm_bus_idx = AudioServer.get_bus_index("BGM")
var sfx_bus_idx = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	# Hide by default if it's an overlay
	hide()
	
	# Connect signals
	master_slider.value_changed.connect(_on_master_slider_value_changed)
	bgm_slider.value_changed.connect(_on_bgm_slider_value_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_value_changed)
	
	close_btn.pressed.connect(_on_close_pressed)
	_add_hover_effect(close_btn)

func _add_hover_effect(btn: Control) -> void:
	btn.pivot_offset = btn.size / 2
	btn.mouse_entered.connect(func(): 
		var tween = create_tween()
		tween.tween_property(btn, "scale", Vector2(1.1, 1.1), 0.1)
	)
	btn.mouse_exited.connect(func(): 
		var tween = create_tween()
		tween.tween_property(btn, "scale", Vector2(1.0, 1.0), 0.1)
	)

func open() -> void:
	show()
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_idx))
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bgm_bus_idx))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_idx))

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_idx, linear_to_db(value))

func _on_bgm_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bgm_bus_idx, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_idx, linear_to_db(value))

func _on_close_pressed() -> void:
	hide()
