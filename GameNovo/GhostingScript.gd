extends Sprite2D

func _ready():
	Ghosting()

func Set_Property(Tx_Pos, Tx_Scale):
	position = Tx_Pos
	self.scale = Tx_Scale

func Ghosting():
	var Tween_Fade = get_tree().create_tween()
	Tween_Fade.tween_property(self, "self_modulate", Color(1, 1, 1, 0), 0.75)
	await Tween_Fade.finished
	queue_free()
