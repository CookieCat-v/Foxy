extends Area2D
class_name  Chest

@onready var anim = $AnimatedSprite2D
@onready var fsm = $ChestFSM
@onready var currentState = $ChestFSM/IdleState
@onready var label

func _ready() -> void:
	currentState._enter(self)


func _change_state(newStatePath: String) -> void:
	var newState = get_node(newStatePath)
	if currentState:
		currentState._exit()
	currentState = newState
	currentState._enter(self)

func _on_body_entered(body: Node2D) -> void:
	if body is Player and body.has_method("add_coin") and body.chest_key_amount > 0:
		currentState._handle_input("open_chest")
		body.chest_key_amount -= 1
		body.add_coin(100)
