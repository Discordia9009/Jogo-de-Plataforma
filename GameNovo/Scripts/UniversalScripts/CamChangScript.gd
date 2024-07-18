extends Node2D

func CameraChanger(Camera1, Camera2, TweenComplet):
	Camera2.set_priority(10)
	if TweenComplet:
		Camera2.set_priority(0)
		Camera1.set_priority(10)
	
