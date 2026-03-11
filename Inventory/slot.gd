extends Panel

@onready var icon: TextureRect = $"item icon"

@onready var quantity_label: Label = $quantity

@export var description: Label

@export var item_icon: TextureRect

# Holds the data for this slot (item + quantity)
var slot_data: InventorySlotData


# This connects the visual slot to the actual inventory data
func set_slot(data: InventorySlotData):

	# Store the slot data reference
	slot_data = data

	# If the slot contains an item
	if data.item:
		# Show the item's icon
		icon.texture = data.item.icon
		
		# Show the quantity number
		quantity_label.text = str(data.quantity)
	else:
		# If the slot is empty, clear the visuals
		icon.texture = null
		quantity_label.text = ""


# Called when the player starts dragging this slot
func _get_drag_data(_position):

	# If the slot itself doesn't exist, stop
	if slot_data == null:
		return
	
	# If the slot has no item, stop
	if slot_data.item == null:
		return
	
	# Create a small preview icon that follows the mouse while dragging
	var preview = TextureRect.new()
	preview.texture = slot_data.item.icon
	preview.custom_minimum_size = Vector2(32, 32)

	# Tell Godot to display this preview during drag
	set_drag_preview(preview)

	# Return this slot as the drag "data"
	# The receiving slot will use this to know where the item came from
	return self
	

# Called by Godot to check if this slot can accept dropped data
func _can_drop_data(_position, data):

	# Only allow dropping if the dragged object has the swap_slots function
	# This ensures only inventory/hotbar slots can interact
	return data.has_method("swap_slots")
	

# Called when something is dropped onto this slot
func _drop_data(_position, data):

	# The slot the item came from
	var from_slot = data

	# Prevent dropping onto itself
	if from_slot == self:
		return

	# Swap the items between the two slots
	swap_slots(from_slot)
	

# Swaps the item data between two slots
func swap_slots(other_slot):

	# Store this slot's current item temporarily
	var temp_item = slot_data.item
	var temp_quantity = slot_data.quantity

	# Move the other slot's item into this slot
	slot_data.item = other_slot.slot_data.item
	slot_data.quantity = other_slot.slot_data.quantity

	# Move the stored item into the other slot
	other_slot.slot_data.item = temp_item
	other_slot.slot_data.quantity = temp_quantity

	# Notify the inventory system that something changed
	# This will trigger the UI to refresh	
	InventoryManager.inventory_updated.emit()


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		if slot_data.item != null:
			description.text = slot_data.item.description
			item_icon.texture = slot_data.item.icon
			
	return
