extends PlayerState


# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	obj.change_animation("jump")
	#AudioManager.play_sound("player_jump")
	obj.velocity.y -= 320
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	
	if obj.velocity.y > 0:
		change_state(fsm.states.fall)
	if not obj.is_on_wall() or abs(obj.velocity.x) <= 99:
		change_state(fsm.states.jump)
	if obj.is_on_floor():
		change_state(fsm.states.idle)
	pass
