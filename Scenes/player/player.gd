class_name  Player
extends BaseCharacter

## Player character class that handles movement, combat, and state management
var is_invulnerable: bool = false
@export var has_blade: bool = true
var chest_key_amount: int = 0

var hud_scene = preload("res://Scenes/ui/hud.tscn")
var hud_instance = null

var pause_menu_scene = preload("res://Scenes/ui/pause_menu.tscn")
var pause_menu_instance = null

var game_over_scene = preload("res://Scenes/ui/game_over.tscn")
var game_over_instance = null

func _ready() -> void:
	get_node("Direction/HitArea2D/CollisionShape2D").disabled = true

	super._ready()
	fsm = FSM.new(self, $States, $States/Idle)
	if has_blade:
		collected_blade()
		
	hud_instance = hud_scene.instantiate()
	get_parent().call_deferred("add_child", hud_instance)
	health_changed.connect(hud_instance.update_health)
	coins_changed.connect(hud_instance.update_coins)
	
	hud_instance.ready.connect(func():
		hud_instance.update_health(health, max_health)
		hud_instance.update_coins(coins)
	)
	
	pause_menu_instance = pause_menu_scene.instantiate()
	get_parent().call_deferred("add_child", pause_menu_instance)


func can_attack() -> bool:
	return has_blade

func collected_blade() -> void:
	has_blade = true
	set_animated_sprite($Direction/BladeAnimatedSprite2D)
			
func _process(delta: float) -> void:
	if position.y > 800:
		var canvas = CanvasLayer.new()
		add_child(canvas)
		
		var fade_rect = ColorRect.new()
		fade_rect.color = Color.BLACK
		fade_rect.modulate.a = 0.0
		fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
		canvas.add_child(fade_rect)
		
		var tween = create_tween()
		tween.tween_property(fade_rect,"modulate:a",1.0,1.0)
		await tween.finished
		get_tree().change_scene_to_file("res://scenes/ui/game_over.tscn")

func _on_hurt_area_2d_hurt(direction: Vector2, damage: float) -> void:
	#print_debug("hitted")
	fsm.current_state.take_damage(damage)
	pass # Replace with function body.
