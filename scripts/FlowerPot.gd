extends Node2D

var gravity = 9.81
var fixed = true
var broken = false
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if !fixed:
		velocity.y += gravity * delta
		$Pot.move_and_collide(velocity)
	pass

func _on_Detection_body_entered(body):
	if body is Player:
		fixed = false
	pass # Replace with function body.


func _on_Collision_body_entered(body):
	if !fixed and !broken and (body is KinematicBody2D or body is TileMap or body is StaticBody2D):
		$Pot/Sprite.play("destroy")
		broken = true
		if body is Player:
			body.kill()
		
	pass # Replace with function body.
