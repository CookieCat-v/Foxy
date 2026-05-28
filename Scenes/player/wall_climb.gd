extends PlayerState

const WALL_SLIDE_SPEED = 20.0
const WALL_JUMP_X = 350.0
const WALL_JUMP_Y = -450.0

func _enter() -> void:
	obj.change_animation("jump")

func _update(delta: float) -> void:

	# Giảm tốc độ rơi khi bám tường
	if obj.velocity.y > WALL_SLIDE_SPEED:
		obj.velocity.y = WALL_SLIDE_SPEED

	# Nhảy khỏi tường
	if Input.is_action_just_pressed("jump"):

		var wall_normal = obj.get_wall_normal()

		obj.velocity.x = wall_normal.x * WALL_JUMP_X
		obj.velocity.y = WALL_JUMP_Y

		change_state(fsm.states.jump)
		return

	# Không còn chạm tường
	if not obj.is_on_wall():
		change_state(fsm.states.fall)
		return

	# Chạm đất
	if obj.is_on_floor():
		change_state(fsm.states.idle)
		return
