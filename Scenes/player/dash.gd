extends PlayerState

var time = 0
# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	obj.change_animation("dash")
	AudioManager.play_sound("player_jump",-1.0)
	time = 0.1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	
	#if Input.is_action_just_pressed("jump"):
		#air_dash = true
	if (time  <= 0):
		if (fsm.current_state==fsm.states.dash):
			change_state(fsm.states.fall)
	else:
		time -= delta
	pass
