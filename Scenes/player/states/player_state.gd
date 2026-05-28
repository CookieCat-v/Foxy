class_name PlayerState
extends FSMState

#Control moving and changing state to run
#Return true if moving
func control_moving() -> bool:
	var dir: float = Input.get_action_strength("right") - Input.get_action_strength("left")
	var is_moving: bool = abs(dir) > 0.1
	#print_debug(is_moving)
	if is_moving:
		dir = sign(dir)
		obj.change_direction(dir)
		obj.velocity.x = obj.movement_speed * dir
		if obj.is_on_floor():
			change_state(fsm.states.run)
		return true
	else:
			obj.velocity.x = 0
	return false
	

#Control jumping
#Return true if jumping
func control_jump() -> bool:
	#If jump is pressed change to jump state and return true
	if Input.is_action_just_pressed("jump") and not obj.is_on_wall():
		change_state(fsm.states.jump)
		obj.jump()
		return true
	elif Input.is_action_just_pressed("jump") and obj.is_on_wall():
		change_state(fsm.states.wallclimb)
		obj.jump()
		return true
	return false
var dash_cd = 0
var air_dash: bool = true
func control_dash(delta: float) ->bool:
	if (dash_cd>0 and air_dash):
		dash_cd-=delta
	if Input.is_action_just_pressed("dash") and dash_cd <=0 and obj.is_on_floor():
		dash_cd = 1.0
		change_state(fsm.states.dash)
		obj.dash()
		return true
	elif Input.is_action_just_pressed("dash") and air_dash and not obj.is_on_floor():
		air_dash = false
		change_state(fsm.states.dash)
		obj.dash()
		return true
	if obj.is_on_floor():
		air_dash = true
	return false
		
func take_damage(damage) -> void:
	#Player take damage
	obj.health -= damage
	if obj.health <= 0:
		change_state(fsm.states.dead)
	#Player die if health is 0 and change to dead state
	#Player hurt if health is not 0 and change to hurt state
	return

func control_attack() -> bool:
	if Input.is_action_just_pressed("attack") and obj.can_attack():
		change_state(fsm.states.attack)
		return true
	return false
