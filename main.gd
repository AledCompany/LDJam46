extends Control


onready var player=$ViewportContainer/Viewport/World/Player
onready var button_trampo=$CanvasLayer/Control/Container/ButtonTrampo
onready var button_wool=$CanvasLayer/Control/Container/ButtonWool
onready var item_invoker=$ViewportContainer/Viewport/World/ItemInvoker
func _ready():
	button_trampo.connect("pressed",item_invoker,"_on_ButtonTrampo_pressed")
	button_wool.connect("pressed",item_invoker,"_on_ButtonWool_pressed")
func _process(delta):

	$bg.material.set_shader_param("offsetx",player_displacement(10).x)
	$bg.rect_position.y=$bg.rect_position.y-$bg.rect_size.y*(player_displacement().y-0.5)

func player_displacement(value:float=1.0)->Vector2:
	var sizex=1280/4
	var sizey=720/4
	var percentx=fmod(player.position.x/value,sizex)/sizex
	var percenty=fmod(player.position.y/value,sizex)/sizey
	return Vector2(percentx,percenty)
