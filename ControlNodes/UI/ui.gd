extends CanvasLayer  # UI layer that stays above world nodes
@onready var Oxygen: TextureProgressBar = $UiControlNode/Node2D/OxygenBar

func _ready() -> void:
	visible = true #so its easier to see my scenes in the editor without the UI covering it up
	EventBus.Deplete_oxygen_signal.connect(deplete_oxygen)
	

func deplete_oxygen(amount: int):
	if Oxygen.value <= 0:
		pass
	else:
		Oxygen.value -= amount
