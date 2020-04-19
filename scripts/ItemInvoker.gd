extends Node2D

class_name ItemInvoker

var currentItem
var currentScene

var _sceneTrampoline = preload("res://scenes/objects/Trampoline.tscn")
var _sceneWool = preload("res://scenes/objects/Wool.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	position = get_global_mouse_position()
	pass
	
func _input(event):
	if event.is_action_pressed("right_click"):
		_clear()
	
	if event.is_action_pressed("left_click") && currentItem != null:
		_invokeScene()
		_clear()
	pass
	
func _clear():
	for child in get_children():
		child.visible = false
	currentScene = null
	currentItem = null

func _on_ButtonTrampo_pressed():
	_clear()
	currentItem = $TrampolineInvoker
	currentScene = _sceneTrampoline
	currentItem.visible = true
	pass # Replace with function body.

func _invokeScene():
	if currentScene != null:
		var instance = currentScene.instance()
		instance.position = self.position
		get_parent().get_node("objects").add_child(instance)


func _on_ButtonWool_pressed():
	_clear()
	currentItem = $WoolInvoker
	currentScene = _sceneWool
	currentItem.visible = true
	pass # Replace with function body.
