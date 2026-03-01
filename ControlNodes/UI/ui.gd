extends CanvasLayer  # UI layer that stays above world nodes

func _ready() -> void:
	visible = true #so its easier to see my scenes in the editor without the UI covering it up


func _process(delta: float) -> void:
	$InventoryUI.visible = PausedState.show_inventory_menu
	
