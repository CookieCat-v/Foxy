extends Control

func _ready() -> void:
	var retry_btn = $ColorRect/VBoxContainer/RetryBtn
	var menu_btn = $ColorRect/VBoxContainer/MenuBtn
	
	retry_btn.pressed.connect(_on_retry)
	menu_btn.pressed.connect(_on_menu)
	
	_add_hover_effect(retry_btn)
	_add_hover_effect(menu_btn)

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

func _on_retry() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stage_1.tscn")

func _on_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/ui/main_menu.tscn")
