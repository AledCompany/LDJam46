extends Node2D

class_name ItemInvoker

signal reset_buttons

var currentItem
var currentScene
var idselected=-1

var _sceneTrampoline = preload("res://scenes/objects/Trampoline.tscn")
var _sceneWool = preload("res://scenes/objects/Wool.tscn")
onready var objects=get_node("../../../objects")

var  obj_left=[]


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
	idselected=-1
	emit_signal("reset_buttons")



func _invokeScene():
	if currentScene != null:
		var instance = currentScene.instance()
		instance.global_position = self.global_position
		print(objects)
		objects.add_child(instance)
		$audio_spawn.play()
		if obj_left.size()>idselected and obj_left[idselected]>0:
			obj_left[idselected]-=1
		
func _on_ButtonTrampo_pressed():
	if obj_left.size()>0 and obj_left[0]>0:
		$audio.play()
		currentItem = $TrampolineInvoker
		currentScene = _sceneTrampoline
		currentItem.visible = true
		idselected=0

func _on_ButtonWool_pressed():
	if obj_left.size()>1 and obj_left[1]>0:
		$audio.play()
		currentItem = $WoolInvoker
		currentScene = _sceneWool
		currentItem.visible = true
		idselected=1
