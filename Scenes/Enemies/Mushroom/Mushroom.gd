extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed = 100
var direction = 1
@onready var frontraycast = $Direction/FrontRayCast2D
@onready var downraycast = $Direction/DownRayCast2D
@onready var groundcast = $Direction/GroundCast2D
@onready var anim = $Direction/AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Moving")
	pass # Replace with function body.



func _physics_process(delta: float) -> void:
	#simulate gravity
	velocity.y += gravity * delta
	if (_should_turn()):
		direction *= -1
		frontraycast.position.x *= -1
		downraycast.position.x *= -1
		frontraycast.rotation_degrees = 180 - frontraycast.rotation_degrees
		anim.flip_h = !anim.flip_h
	#move
	velocity.x = speed * delta * direction
	move_and_slide()
func _should_turn() -> bool:
	if frontraycast.is_colliding():
		return true
	if groundcast.is_colliding() and !downraycast.is_colliding():
		return true
	return false
	
