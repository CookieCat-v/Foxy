extends CanvasLayer

@onready var master_slider = $Control/PopupBackground/VBoxContainer/MasterRow/MasterSlider
@onready var bgm_slider = $Control/PopupBackground/VBoxContainer/BGMRow/BGMSlider
@onready var sfx_slider = $Control/PopupBackground/VBoxContainer/SFXRow/SFXSlider

@onready var resume_btn = $Control/PopupBackground/VBoxContainer/HBoxContainer/ResumeBtn
@onready var restart_btn = $Control/PopupBackground/VBoxContainer/HBoxContainer/RestartBtn
@onready var menu_btn = $Control/PopupBackground/VBoxContainer/HBoxContainer/MenuBtn

var master_bus_idx = AudioServer.get_bus_index("Master")
var bgm_bus_idx = AudioServer.get_bus_index("BGM")
var sfx_bus_idx = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	hide()
	
	resume_btn.pressed.connect(_on_resume)
	restart_btn.pressed.connect(_on_restart)
	menu_btn.pressed.connect(_on_menu)
	
	master_slider.value_changed.connect(_on_master_slider_value_changed)
	bgm_slider.value_changed.connect(_on_bgm_slider_value_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_value_changed)
	
	_add_hover_effect(resume_btn)
	_add_hover_effect(restart_btn)
	_add_hover_effect(menu_btn)

func open() -> void:
	show()
	get_tree().paused = true
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_idx))
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bgm_bus_idx))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_idx))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			_on_resume()
		else:
			open()

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

func _on_resume() -> void:
	hide()
	get_tree().paused = false

func _on_restart() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stage_1.tscn")

func _on_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/ui/main_menu.tscn")

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_idx, linear_to_db(value))

func _on_bgm_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bgm_bus_idx, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_idx, linear_to_db(value))
