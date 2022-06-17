extends KinematicBody2D

onready var anim_tree= $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var detec_area= $AreaDeteccion
onready var pivot = $Pivot
onready var sprite = $Pivot/Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var SPEED = 151
var ACCELERATION = 550
var GRAVITY = 400

var velocity = Vector2()
var _target: Node2D = null


func _ready():
	pass # Replace with function body.
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
		
	if velocity.x > 0:
		pivot.scale.x = 1
	if velocity.x < 0:
		pivot.scale.x = -1


#func take_damage(instigator: Node2D):
	pass
func take_damage():
	playback.travel("hurt")




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_body_entered(body: Node):
	_target= body
