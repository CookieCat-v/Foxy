extends CharacterBody2D

var direction = 1
@export var speed = 200
@onready var raycast = $FrontCast2D
func _physics_process(delta: float) -> void:
	velocity.x = speed * direction
	if raycast.is_colliding():
		queue_free()
	move_and_slide()

func _set_direction(direct: int) -> void:
	direction = direct
	
