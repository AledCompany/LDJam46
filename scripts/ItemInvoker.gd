extends Node2D

class_name ItemInvoker

signal reset_buttons

var currentItem
var currentScene

var _sceneTrampoline = preload("res://scenes/objects/Trampoline.tscn")
var _sceneWool = preload("res://scenes/objects/Wool.tscn")
onready var objects=get_node("../../../objects")


func set_position(newpos):
	global_position=-get_canvas_transform().origin+newpos

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
	emit_signal("reset_buttons")



func _invokeScene():
	if currentScene != null:
		var instance = currentScene.instance()
		instance.global_position = self.global_position
		print(objects)
		objects.add_child(instance)
		
func _on_ButtonTrampo_pressed():
	currentItem = $TrampolineInvoker
	currentScene = _sceneTrampoline
	currentItem.visible = true

func _on_ButtonWool_pressed():
	currentItem = $WoolInvoker
	currentScene = _sceneWool
	currentItem.visible = true
