extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed = 200
var direction = 1
@onready var frontraycast = $Direction/FrontRayCast2D
@onready var downraycast = $Direction/DownRayCast2D
@onready var groundcast = $Direction/GroundCast2D
@onready var anim = $Direction/AnimatedSprite2D

func _ready() -> void:
	anim.play("Moving")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	#simulate gravity
	velocity.y += gravity * delta
	
	if (_should_turn()):
		direction = -direction
		_update_orientation()
		
	#move
	velocity.x = speed * direction
	move_and_slide()
	
func _should_turn() -> bool:
	if frontraycast.is_colliding():
		return true
	if groundcast.is_colliding() and !downraycast.is_colliding():
		return true
	return false
	
func _update_orientation() -> void:
	var direction_node = $Direction
	
	if direction_node:
		if direction == 1:
			direction_node.scale.x = 1
		else:
			direction_node.scale.x = -1
	
