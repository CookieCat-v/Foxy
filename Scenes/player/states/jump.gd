extends PlayerState

func _enter() -> void:
	#Change animation to jump
	obj.change_animation("jump")
	AudioManager.play_sound("player_jump")
	air_dash = true;
	pass

func _update(_delta: float):
	#Control moving
	control_moving()
	control_dash(_delta)
#	if obj.is_on_wall():
#		control_jump()
	#If velocity.y is greater than 0 change to fall
	if obj.velocity.y > 0:
		change_state(fsm.states.fall)
	pass
