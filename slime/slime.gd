extends KinematicBody2D

onready var anim_tree= $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var detec_area= $AreaDeteccion



var SPEED = 151
var ACCELERATION = 550
var GRAVITY = 400

var velocity = Vector2()
var _target: Node2D = null


func _ready():
	anim_tree.active = true
	detec_area.connect("body_entered", self, "_on_body_entered")

func _physics_process(delta):
	velocity= move_and_slide(velocity, Vector2.UP)
	
	var move_input= 0
	
	if _target:
		var diff= _target.global_position.x - global_position.x
		move_input = sign(diff)
		
	velocity.x = move_toward(velocity.x, move_input* SPEED, ACCELERATION)
	velocity.y += GRAVITY *delta
		
		
	if _target and is_on_floor() and _target.global_position.y < global_position.y - 20:
			velocity.y = -1 * SPEED
	
		
	if abs(velocity.x) > 10:
		playback.travel("walk")
	else:
		playback.travel("idle")

#func take_damage(instigator: Node2D):
	pass
func take_damage():
	playback.travel("hurt")

func _on_body_entered(body: Node):
	_target= body
