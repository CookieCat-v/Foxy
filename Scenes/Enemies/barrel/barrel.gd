extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var raycast = $FrontCast2D
var bullet_scene = preload("res://Scenes/Enemies/barrel/barrel_bullet.tscn")
var direction = 1
func _ready() -> void:
	anim.play("idle")
func _process(delta: float) -> void:
	if anim.animation=="idle" and raycast.is_colliding():
		_fire()
func _fire()->void:
	anim.play("attack")
	var bullet = bullet_scene.instantiate()
	bullet.position = Vector2(position.x+(8*direction),position.y)
	await get_tree().create_timer(0.6).timeout
	bullet._set_direction(direction)
	
	get_parent().add_child(bullet)
	


func _on_attack_finished() -> void:
	print_debug("test")
	if (anim.animation=="attack"): 
		anim.play("idle")
