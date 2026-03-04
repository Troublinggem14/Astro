extends CanvasLayer  # UI layer that stays above world nodes

func _ready() -> void:
	visible = true #so its easier to see my scenes in the editor without the UI covering it up
	$InventoryUI.hide()
	
func _process(delta: float) -> void:
	if PausedState.show_inventory_menu == true:
		$InventoryUI.show()
	else:
		$InventoryUI.hide()
