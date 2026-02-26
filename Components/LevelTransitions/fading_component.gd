extends CanvasLayer
@onready var fading: AnimationPlayer = $Fading

func FadeOut():
	fading.play("FadeOut")
func FadeIn():
	fading.play("FadeIn")
