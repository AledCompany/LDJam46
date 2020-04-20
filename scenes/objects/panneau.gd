extends Area2D


signal tuto(text,param)
export var text=""
export var param:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_panneau_body_entered(body):
	if body is Player:
		emit_signal("tuto",text,param)
