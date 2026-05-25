extends PlayerState


func _enter():
	obj.change_animation("dead")
	timer = 1.0
	obj.velocity.x = 0
	obj.animated_sprite.animation_finished.connect(handle_dead)
	


#func _update(delta):
	#if update_timer(delta):
		#obj.queue_free()



func handle_dead() -> void:
	var canvas = CanvasLayer.new()
	add_child(canvas)
	
	var fade_rect = ColorRect.new()
	fade_rect.color = Color.BLACK
	fade_rect.modulate.a = 0.0
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(fade_rect)
	
	var tween = create_tween()
	tween.tween_property(fade_rect,"modulate:a",1.0,1.0)
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/ui/game_over.tscn")
	pass # Replace with function body.
