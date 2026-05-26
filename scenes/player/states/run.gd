extends PlayerState

func _enter() -> void:
	#Change animation to run
	obj.change_animation("run")
	pass

func _update(delta: float):
	#Control jump
	if control_jump():
		return
	#Control moving and if not moving change to idle
	if not control_moving():
		change_state(fsm.states.idle)
	control_dash(delta)
	#If not on floor change to fall
	if obj.is_on_floor():
		timer = delta + 0.1
	#If not on floor change to fall
	if not obj.is_on_floor():
		if update_timer(delta):
			change_state(fsm.states.fall)
	pass
