extends Node2D

class_name ItemInvoker

var currentItem
var currentScene

var _sceneTrampoline = preload("res://scenes/objects/Trampoline.tscn")
var _sceneWool = preload("res://scenes/objects/Wool.tscn")
onready var objects=get_node("../../../objects")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var real_size=OS.get_window_size()
	#print("item",get_global_mouse_position())
	#position = get_global_mouse_position()* get_viewport_rect().size/OS.get_window_size()
#	if real_size.x*9<real_size.y*16:
#		print("x")
#		real_size.y=real_size.x*9/16
#	else:
#		print("y")
#		real_size.x=real_size.y*16/9
#	print(real_size)
#	position = get_global_mouse_position()* get_viewport_rect().size/real_size
#	position.x+=get_viewport_rect().size.x
#	position.y-=get_viewport_rect().size.y
	#position.x-=OS.get_window_size().x/2-get_viewport_rect().size.x/2

func set_position(newpos):
	#position=newpos-get_viewport_rect().size/2
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

func _on_ButtonTrampo_pressed():
	_clear()
	currentItem = $TrampolineInvoker
	currentScene = _sceneTrampoline
	currentItem.visible = true
	print("ok")
	pass # Replace with function body.

func _invokeScene():
	if currentScene != null:
		var instance = currentScene.instance()
		instance.global_position = self.global_position
		print(objects)
		objects.add_child(instance)


func _on_ButtonWool_pressed():
	_clear()
	currentItem = $WoolInvoker
	currentScene = _sceneWool
	currentItem.visible = true
	pass # Replace with function body.
