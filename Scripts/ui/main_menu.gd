extends Control

var settings_scene = preload("res://Scenes/ui/settings_menu.tscn")
var settings_instance = null

func _ready() -> void:
	var play_btn = $VBoxContainer/PlayBtn
	var settings_btn = $VBoxContainer/HBoxContainer/SettingsBtn
	var quit_btn = $VBoxContainer/HBoxContainer/QuitBtn
	
	play_btn.pressed.connect(_on_play)
	settings_btn.pressed.connect(_on_settings)
	quit_btn.pressed.connect(_on_quit)
	
	for btn in [play_btn, settings_btn, quit_btn]:
		_add_hover_effect(btn)
	
	settings_instance = settings_scene.instantiate()
	add_child(settings_instance)

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


func _on_play() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stage_1.tscn")

func _on_settings() -> void:
	settings_instance.open()

func _on_quit() -> void:
	get_tree().quit()
