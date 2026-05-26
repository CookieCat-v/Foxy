extends PlayerState

var time = 0
# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	obj.change_animation("dash")
	AudioManager.play_sound("player_jump",-1.0)
	time = 0.1
	if obj.velocity.x == 0:
			obj.velocity.x = (500+obj.movement_speed) * obj.direction 
	else:
			obj.velocity.x +=  500 * obj.direction
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if obj.is_on_floor():
		control_jump()

	if (time  <= 0):
		if (fsm.current_state==fsm.states.dash):
			change_state(fsm.states.idle)
	else:
		time -= delta
	pass
