extends KinematicBody2D

onready var anim_tree= $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var anim_player= $AnimationPlayer
onready var detection_area= $AreaDeteccion


var SPEED = 151
var ACCELERATION = 550
var GRAVITY = 400

var velocity = Vector2()
var _target: KinematicBody = null


func _ready():
	anim_tree.active = true
	detection_area.connect("body_entered", self, "on_body_entered")

func _physics_process(delta):
	velocity= move_and_slide(velocity, Vector2.UP)
	
	var move_input= 0
	
	if _target:
		move_input = sign(_target.global_position.x - global_position.x)
		
	velocity.x = move_toward(velocity.x, move_input* SPEED, ACCELERATION)
	velocity.y += GRAVITY *delta

#func take_damage(instigator: Node2D):
	pass
func take_damage():
	playback.travel("hurt")

func _on_body_entered(body: Node):
	_target= body
