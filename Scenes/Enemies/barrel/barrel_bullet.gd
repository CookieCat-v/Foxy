extends CharacterBody2D

var direction = 1
@export var speed = 200
@onready var hitarea = $HitArea2D
func _physics_process(delta: float) -> void:
	velocity.x = speed * direction
	move_and_slide()

func _set_direction(direct: int) -> void:
	direction = direct
	




func _on_hit_area_2d_hitted(_body: Node2D) -> void:
	queue_free()
	pass # Replace with function body.
