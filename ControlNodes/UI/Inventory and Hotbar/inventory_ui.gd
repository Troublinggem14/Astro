extends Control  # Root node for the full inventory UI panel

@export var inventory: Inventory  
# Reference to the shared Inventory data model

@export var slot_scene: PackedScene  
# Scene used to visually represent one inventory slot

@onready var grid: GridContainer = $GridContainer  
# Container that automatically arranges slot UI elements in a grid layout

@onready var time_label = $PanelContainer/Label

func _ready():
	create_slots()  

	# Connect inventory signal → automatic UI refresh on data change
	inventory.connect("inventory_updated", update_ui)

	update_ui()  # Initial population of slot visuals

func _process(delta: float) -> void:
	if visible:
		time_label.text = TimeManager.get_formatted_time()


func create_slots():
	# Create one visual slot for each inventory slot in the data model.
	# This ensures UI size always matches inventory.size.
	for i in range(inventory.size):
		var slot = slot_scene.instantiate()
		grid.add_child(slot)

		# Connect each slot's click signal to this UI
		# Allows this script to react when user clicks a slot
		slot.connect("slot_clicked", _on_slot_clicked)


func _on_slot_clicked(item, amount):
	# This is where interaction logic would go later
	# (use item, split stack, inspect, drop, etc.)
	print("Clicked:", item.name, amount)


func update_ui():
	# Synchronizes grid visuals with inventory data array.
	# Called whenever inventory emits "inventory_updated".

	for i in range(grid.get_child_count()):
		var slot_ui = grid.get_child(i)
		var slot_data = inventory.slots[i]

		if slot_data != null:
			# Delegate visual update to slot component
			slot_ui.set_item(slot_data["item"], slot_data["amount"])
		else:
			slot_ui.clear()
