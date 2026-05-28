extends Control

func _ready() -> void:
	var play_again_btn = $VBoxContainer/PlayAgainBtn
	var exit_btn = $VBoxContainer/ExitBtn
	
	play_again_btn.pressed.connect(_on_play_again)
	exit_btn.pressed.connect(_on_exit)
	
	_add_hover_effect(play_again_btn)
	_add_hover_effect(exit_btn)

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

func _on_play_again() -> void:
	if get_node_or_null("/root/AudioManager"):
		pass
	get_tree().change_scene_to_file("res://Scenes/Stage_1.tscn")

func _on_exit() -> void:
	get_tree().quit()
