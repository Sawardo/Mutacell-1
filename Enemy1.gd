

class_name Enemy
extends KinematicBody2D
onready var AnimationGolpe = $AnimationPlayer


func take_damage():
	AnimationGolpe.play("idleesp")
	
	
	


