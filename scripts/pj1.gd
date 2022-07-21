extends KinematicBody2D

var a = 1
var SPEED = 200
var ACCELERATION = 500
var GRAVITY = 400

var velocity = Vector2()
var specialattackposition = null
var vectorcito
var colisioncita
var dasheando

onready var areaLatigo = $Pivot/areaLatigo
onready var sprite = $Pivot/Sprite
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var pivot = $Pivot
onready var rayCastLatigo = $Pivot/RayCastLatigo


func _ready():
	anim_tree.active = true
	areaLatigo.connect("body_entered", self, "_on_body_entered")
	rayCastLatigo.add_exception(self)

func _physics_process(delta):
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if dasheando:
		move_and_slide(vectorcito*1000)
		if get_slide_count() > 0:
			velocity.y = -1.4 * SPEED
			dasheando = false
	else:
		
		
		var move_input = Input.get_axis("left", "right")
		
		
		velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION)
		
		if not is_on_floor() and velocity.y <= 0:
			velocity.y += GRAVITY * delta
			
		if not is_on_floor() and velocity.y >= 0 and velocity.y < 3000:
			velocity.y += GRAVITY * delta
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = -1.4 * SPEED
	
	
	# Change Character
	#if Input.is_action_just_pressed("change"):
	#	if a == 1:
	#		playback.travel("transida")
	#		playback.travel("transgunvue")
	#		a = 2
	#	elif a == 2:
	#		playback.travel("transgunida")
	#		playback.travel("transarchvue")
	#		a = 3
	#	elif a == 3:
	#		playback.travel("transarchida")
	#		playback.travel("transvue")
	#		a = 1
	
	
	
 #Change Character
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
			specialattackposition = null
			print("hem")
		elif Input.is_action_just_pressed("sataque"):
			playback.travel("attack2")
			if rayCastLatigo.is_colliding():
				var target = rayCastLatigo.get_collider()
				vectorcito = global_position.direction_to(target.global_position)
				print_debug(vectorcito)
				move_and_slide(vectorcito*1000)
				dasheando = true
				
#			if specialattackposition:
#				vectorcito = (specialattackposition - global_position).normalized()
#				vectorcito = null
#				specialattackposition = null
				
			print("meh")
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

# Arch
	if a == 3:
		if is_on_floor():
			if abs(velocity.x) > 10:
				playback.travel("runarch")
			else:
				playback.travel("idlearch")
		else:
			if velocity.y > 0:
				playback.travel("fallarch")
			else:
				playback.travel("jumparch")


	if Input.is_action_pressed("right") and not Input.is_action_just_pressed("left"):
		pivot.scale.x = 1
	if Input.is_action_pressed("left") and not Input.is_action_just_pressed("right"):
		pivot.scale.x = -1

func _on_body_entered(body: Node):
	if body.has_method("take_damage"):
		specialattackposition = body.global_position
		body.take_damage()








