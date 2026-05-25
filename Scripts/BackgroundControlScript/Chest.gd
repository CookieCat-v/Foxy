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

#func addScore() -> void:
	#if label:
		#var currentScore = int(label.text)
		#currentScore += 1000
		#label.text = str(currentScore)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		#label = body.get_parent().get_node("CanvasLayer").get_node("ScoreLabel")
		currentState._handle_input("open_chest")
