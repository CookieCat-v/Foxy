extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var raycast = $FrontCast2D
@onready var back_raycast = $BackCast2D
var bullet_scene = preload("res://Scenes/Enemies/barrel/barrel_bullet.tscn")
@export var direction = 1

func _ready() -> void:
	_update_direction()
	anim.play("idle")
	
func _process(delta: float) -> void:
	if back_raycast.is_colliding():
		var collider = back_raycast.get_collider()
		if collider and collider.name == "Player":
			direction = -direction
			_update_direction()
	
	if anim.animation=="idle" and raycast.is_colliding():
		_fire()	
	

func _update_direction()->void:
	if direction == -1:
		anim.flip_h = true
		raycast.target_position.x = -abs(raycast.target_position.x)
		back_raycast.target_position.x = abs(back_raycast.target_position.x)
	else:
		anim.flip_h = false
		raycast.target_position.x = abs(raycast.target_position.x)
		back_raycast.target_position.x = -abs(back_raycast.target_position.x)
		
func _fire()->void:
	anim.play("attack")
	var bullet = bullet_scene.instantiate()
	bullet.position = Vector2(position.x+(8*direction),position.y)
	await get_tree().create_timer(0.6).timeout
	bullet._set_direction(direction)
	
	get_parent().add_child(bullet)
	
func _on_attack_finished() -> void:
	if (anim.animation=="attack"): 
		anim.play("idle")
