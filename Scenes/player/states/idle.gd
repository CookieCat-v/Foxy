extends PlayerState

## Idle state for player character

func _enter() -> void:
	obj.change_animation("idle")
	#print_debug("idle")

func _update(delta: float) -> void:
	#Control jump
	control_jump()
	control_dash(delta)
	#Control moving
	control_moving()
	control_attack()
	#coyote time
	if obj.is_on_floor():
		timer = delta + 0.25
	#If not on floor change to fall
	if not obj.is_on_floor():
		#true khi het coyote time
		if update_timer(delta):
			change_state(fsm.states.fall)
	pass
