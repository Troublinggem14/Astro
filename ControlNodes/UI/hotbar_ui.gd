extends Control  # UI root for the hotbar

@export var inventory: Inventory  # Reference to the main inventory data
@export var slot_scene: PackedScene  # Scene used to visually represent one slot

@onready var container: HBoxContainer = $HBoxContainer  
# Cached reference to the UI container holding the slot instances

var hotbar_size: int = 5  # Number of visible hotbar slots (subset of full inventory)
var selected_index: int = 0  # Which slot is currently active


func _ready():
	create_slots()  # Instantiate UI slot nodes
	inventory.connect("inventory_updated", update_ui)
	# Connect inventory signal → UI auto refresh when data changes
	
	update_ui()         # Initial draw
	update_selection()  # Highlight default selection


func create_slots():
	# Create exactly hotbar_size UI slot instances
	# These are purely visual — they mirror inventory.slots
	for i in range(hotbar_size):
		var slot = slot_scene.instantiate()
		container.add_child(slot)


func update_ui():
	# Sync visual slots with inventory data
	for i in range(hotbar_size):
		var slot_ui = container.get_child(i)

		# Safety check in case inventory size is smaller than hotbar
		if i < inventory.slots.size():
			var slot_data = inventory.slots[i]

			if slot_data != null:
				# Pass item data into the slot UI script
				slot_ui.set_item(slot_data["item"], slot_data["amount"])
			else:
				slot_ui.clear()  # Empty slot visually
		else:
			slot_ui.clear()


func _input(event):

	# Scroll wheel navigation
	# Modular arithmetic allows wrap-around selection
	if event.is_action_pressed("scroll_up"):
		selected_index = (selected_index - 1 + hotbar_size) % hotbar_size
		update_selection()

	if event.is_action_pressed("scroll_down"):
		selected_index = (selected_index + 1) % hotbar_size
		update_selection()

	# Direct selection using number keys
	# These map input actions → specific slot index
	if event.is_action_pressed("hotbar_1"):
		set_selected(0)

	if event.is_action_pressed("hotbar_2"):
		set_selected(1)

	if event.is_action_pressed("hotbar_3"):
		set_selected(2)

	if event.is_action_pressed("hotbar_4"):
		set_selected(3)

	if event.is_action_pressed("hotbar_5"):
		set_selected(4)


func set_selected(index: int):
	selected_index = index
	update_selection()


func update_selection():
	# Visually highlight selected slot
	for i in range(hotbar_size):
		var slot_ui = container.get_child(i)

		if i == selected_index:
			# Full brightness for active slot
			slot_ui.modulate = Color(1, 1, 1, 1)
		else:
			# Slightly darkened for inactive slots
			slot_ui.modulate = Color(0.7, 0.7, 0.7, 1)


func get_selected_item():
	# Prevent out-of-bounds access if inventory smaller than hotbar
	if selected_index >= inventory.slots.size():
		return null

	var data = inventory.slots[selected_index]

	if data != null:
		return data["item"]  # Return only the item resource (not amount)

	return null
