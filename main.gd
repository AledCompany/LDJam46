extends Control


#onready var player=$ViewportContainer/Viewport.get_child(0).get_node("Player")
onready var button_trampo=$CanvasLayer/Control/Container/ButtonTrampo
onready var button_wool=$CanvasLayer/Control/Container/ButtonWool
var item_invoker=null
var world=null


onready var bg_initpos=$bg.rect_position+$bg.rect_size
onready var bg1_initpos=$bg1.rect_position+$bg1.rect_size
onready var bg2_initpos=$bg2.rect_position+$bg2.rect_size

enum State{
	title,
	before_level,
	level,
	after_level,
	game_over,
	restart
}

var current_level=0

var levels=[{"scene":preload("res://scenes/levels/level1.tscn"),"desc":"First delivery"}]
var state=State.title

func _ready():
	$CanvasLayer/Control/pause_button.connect("pressed",self,"_pause")

func _process(delta):
	move_item_invoker()
	move_background()
func move_item_invoker():
	if state==State.level:
		item_invoker.set_position(get_global_mouse_position())

func move_background():
	if state==State.level:
		$bg.material.set_shader_param("offsetx",-player_displacement(10).x)
		$bg.rect_position.y=bg_initpos.y-$bg.rect_size.y*(player_displacement().y)
		$bg1.material.set_shader_param("offsetx",-player_displacement(5).x)
		$bg1.rect_position.y=bg1_initpos.y-$bg1.rect_size.y*(player_displacement().y)
		$bg2.material.set_shader_param("offsetx",-player_displacement(1).x)
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

func display_panel(text:String,param:Dictionary):
	$tuto_cont/Panel/Label.text=text
	$anim_indication.play("open")
	get_tree().paused=true
	if param.has("activate_hud"):
		$anim_hud.play("open")

func _on_CenterContainer_gui_input(event):
	if event is InputEventMouseButton and !$anim_indication.is_playing():
		$anim_indication.play_backwards("open")
		get_tree().paused=false


func transition_change():
	if state==State.title:
		$title.visible=false
		$game_over.visible=false
		$after_level.visible=false
		$before_level.visible=true
		$before_level/label.text="Level "+str(current_level)
		$before_level/label2.text=levels[current_level]["desc"]
		state=State.before_level
	elif state==State.before_level:
		$before_level.visible=false
		call_deferred("set_level",current_level)
	elif state==State.after_level:
		$after_level.visible=true
		$ViewportContainer/Viewport.get_child(0).queue_free()
	elif state==State.game_over:
		$ViewportContainer/Viewport.get_child(0).queue_free()
		$game_over.visible=true
	elif state==State.restart:
		get_tree().reload_current_scene()

func set_level(id):
	if $ViewportContainer/Viewport.get_child_count()>0:
		$ViewportContainer/Viewport.get_child(0).queue_free()
	var tmp=levels[id]["scene"].instance()
	$ViewportContainer/Viewport.add_child(tmp)
	world=$ViewportContainer/Viewport.get_child(0)
	item_invoker=$ViewportContainer/Viewport.get_child(0).get_node("Player/Camera2D/ItemInvoker")
	state=State.level
	button_trampo.connect("pressed",item_invoker,"_on_ButtonTrampo_pressed")
	button_wool.connect("pressed",item_invoker,"_on_ButtonWool_pressed")
	item_invoker.connect("reset_buttons",self,"_reset_buttons")
	$ViewportContainer/Viewport.get_child(0).get_node("objects/maison").connect("level_finished",self,"level_finished")
	connect_panels()
	$ViewportContainer/Viewport.get_child(0).get_node("Player").connect("dead",self,"_player_dead")

func _player_dead():
	state=State.game_over
	$anim_transition.play("transition")
	$anim_hud.play_backwards("open")
	
func level_finished(envelope,timer):
	state=State.after_level
	$after_level/enveloppe.visible=envelope
	$anim_hud.play_backwards("open")
	var timer_string="Time "+str("%02d:" % int(timer/60))+str(fmod(timer,60)).pad_zeros(2).pad_decimals(2)
	$after_level/label3.text=timer_string
	$anim_transition.play("transition")

func _on_Button_pressed():
	if state==State.before_level:
		$anim_transition.play("transition")

func _reset_buttons():
	button_trampo.pressed=false
	button_wool.pressed=false
func _on_button_title_pressed():
	if state==State.title:
		$anim_transition.play("transition")


func _on_restart_pressed():
	state=State.title
	$anim_transition.play("transition")


func _on_home_pressed():
	state=State.restart
	$anim_transition.play("transition")


func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_next_pressed():
	if levels.size()>current_level+1:
		current_level+=1
		state=State.title
		$anim_transition.play("transition")

func _pause():
	get_tree().paused=true
	$pause.visible=true
	$anim_hud.play_backwards("open")

func _on_button_continue_pressed():
	get_tree().paused=false
	$pause.visible=false
	$anim_hud.play("open")
