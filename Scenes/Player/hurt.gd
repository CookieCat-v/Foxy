extends PlayerState


func _enter():
	obj.change_animation("hurt")
	timer = 0.2
	obj.velocity = Vector2(-obj.direction*200,-250)


func _update( delta: float):
	if update_timer(delta):
		if obj.health <= 0:
			change_state(fsm.states.dead)
		else:
			change_state(fsm.default_state)
