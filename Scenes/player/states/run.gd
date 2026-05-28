extends PlayerState

func _enter() -> void:
	#Change animation to run
	obj.change_animation("run")
	pass

func _update(delta: float):
	if not control_moving():
		change_state(fsm.states.idle)

	#Control moving and if not moving change to idle
	
	control_dash(delta)
		#Control jump
	if control_jump():
		return
	#If not on floor change to fall
	if obj.is_on_floor():
		timer = delta + 0.25
	#If not on floor change to fall
	if not obj.is_on_floor():
		if update_timer(delta):
			change_state(fsm.states.fall)
	pass
