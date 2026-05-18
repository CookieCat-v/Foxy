extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _physics_process(delta: float) -> void:
	#simulate gravity
	velocity.y += gravity * delta
	#move
	velocity.x += speed * delta
	move_and_slide()
