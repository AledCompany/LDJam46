extends Control


onready var player=$ViewportContainer/Viewport.get_child(0).get_node("Player")
onready var button_trampo=$CanvasLayer/Control/Container/ButtonTrampo
onready var button_wool=$CanvasLayer/Control/Container/ButtonWool
onready var item_invoker=$ViewportContainer/Viewport.get_child(0).get_node("Player/Camera2D/ItemInvoker")
onready var world=$ViewportContainer/Viewport.get_child(0)


onready var bg_initpos=$bg.rect_position+$bg.rect_size
onready var bg1_initpos=$bg1.rect_position+$bg1.rect_size
onready var bg2_initpos=$bg2.rect_position+$bg2.rect_size
func _ready():
	button_trampo.connect("pressed",item_invoker,"_on_ButtonTrampo_pressed")
	button_wool.connect("pressed",item_invoker,"_on_ButtonWool_pressed")
	connect_panels()
func _process(delta):
	item_invoker.set_position(get_global_mouse_position())
	$bg.material.set_shader_param("offsetx",player_displacement(10).x)
	$bg.rect_position.y=bg_initpos.y-$bg.rect_size.y*(player_displacement().y)
	$bg1.material.set_shader_param("offsetx",player_displacement(5).x)
	$bg1.rect_position.y=bg1_initpos.y-$bg1.rect_size.y*(player_displacement().y)
	$bg2.material.set_shader_param("offsetx",player_displacement(1).x)
	$bg2.rect_position.y=bg2_initpos.y-$bg1.rect_size.y*(player_displacement().y)

func player_displacement(value:float=1.0)->Vector2:
	var sizex=1280/4
	var sizey=720/4
	var percentx=fmod(world.get_canvas_transform().origin.x/value,sizex)/sizex
	var percenty=fmod(world.get_canvas_transform().origin.y/value,sizex)/sizey
	return Vector2(percentx,percenty)

func connect_panels():
	for panel in get_tree().get_nodes_in_group("panel"):
		panel.connect("tuto",self,"display_panel")

func display_panel(text:String):
	$tuto_cont/Panel/Label.text=text
	$anim_indication.play("open")
	get_tree().paused=true

func _on_CenterContainer_gui_input(event):
	print("ok")
	if event is InputEventMouseButton and !$anim_indication.is_playing():
		$anim_indication.play_backwards("open")
		get_tree().paused=false
