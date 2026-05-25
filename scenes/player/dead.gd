extends PlayerState


func _enter():
	obj.change_animation("dead")
	timer = 1.0
	obj.velocity.x = 0
	
	


#func _update(delta):
	#if update_timer(delta):
		#obj.queue_free()



func _on_animated_sprite_2d_animation_finished() -> void:
	if obj.get_animation_name() == "dead":
		get_tree().change_scene_to_file("res://scenes/ui/game_over.tscn")
	pass # Replace with function body.
