extends KinematicBody2D

var a = 1
var SPEED = 200
var ACCELERATION = 500
var GRAVITY = 400

var velocity = Vector2()


onready var areaLatigo = $Pivot/areaLatigo
onready var sprite = $Pivot/Sprite
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var pivot = $Pivot



func _ready():
	anim_tree.active = true
	areaLatigo.connect("body_entered", self, "_on_body_entered")

func _physics_process(delta):
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Input.get_axis("left", "right")
	
	
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION)
	
	if not is_on_floor() and velocity.y <= 0:
		velocity.y += GRAVITY * delta
		
	if not is_on_floor() and velocity.y >= 0 and velocity.y < 3000:
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -1.4 * SPEED
	
	
	
# Change Character
	if Input.is_action_just_pressed("change"):
		if a == 1:
			playback.travel("transida")
			playback.travel("transgunvue")
			a = 2
		elif a == 2:
			playback.travel("transgunida")
			playback.travel("transvue")
			a = 1



# Whip
	if a == 1:
		if Input.is_action_just_pressed("ataque"):
			playback.travel("attack1")
			print("hem")
		elif is_on_floor():
			if abs(velocity.x) > 10:
				playback.travel("run")
			else:
				playback.travel("idle")
		else:
			if velocity.y > 0:
				playback.travel("fall")
			else:
				playback.travel("jump")
			
		
		

# Gun
	if a == 2:
		if is_on_floor():
			if abs(velocity.x) > 10:
				playback.travel("rungun")
			else:
				playback.travel("idlegun")
		else:
			if velocity.y > 0:
				playback.travel("fallgun")
			else:
				playback.travel("jumpgun")


	if Input.is_action_pressed("right") and not Input.is_action_just_pressed("left"):
		pivot.scale.x = 1
	if Input.is_action_pressed("left") and not Input.is_action_just_pressed("right"):
		pivot.scale.x = -1

func _on_body_entered(body: Node):
	if body.has_method("take_damage"):
		body.take_damage()








