extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var HitTopBoundary = false
var HitBottomBoundary = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TopArea2D_area_entered(_area):
	HitTopBoundary = true


func _on_TopArea2D_area_exited(_area):
	HitTopBoundary = false


func _on_BottomArea2D_area_entered(_area):
	HitBottomBoundary = true


func _on_BottomArea2D_area_exited(_area):
	HitBottomBoundary = false
