class_name Player
extends BaseCharacter

## Player character class that handles movement, combat, and state management
var is_invulnerable: bool = false
@export var has_blade: bool = true

var hud_scene = preload("res://Scenes/ui/hud.tscn")
var hud_instance = null

var pause_menu_scene = preload("res://Scenes/ui/pause_menu.tscn")
var pause_menu_instance = null

func _ready() -> void:
	$Direction/HitArea2D.hide()
	super._ready()
	fsm = FSM.new(self, $States, $States/Idle)
	if has_blade:
		collected_blade()
		
	hud_instance = hud_scene.instantiate()
	get_parent().call_deferred("add_child", hud_instance)
	health_changed.connect(hud_instance.update_health)
	coins_changed.connect(hud_instance.update_coins)
	hud_instance.update_health(health, max_health)
	hud_instance.update_coins(coins)
	
	pause_menu_instance = pause_menu_scene.instantiate()
	get_parent().call_deferred("add_child", pause_menu_instance)


func can_attack() -> bool:
	return has_blade

func collected_blade() -> void:
	has_blade = true
	set_animated_sprite($Direction/BladeAnimatedSprite2D)
			
func _on_hurt_area_2d_hurt(_direction: Variant, _damage: Variant) -> void:
	#print_debug("hit")
	fsm.current_state.take_damage(_damage)
