extends Node
class_name Inventory  # Allows this script to be used as a type and accessed globally

signal inventory_updated  # Emitted whenever inventory data changes so UI can refresh

@export var size: int = 20  # Total number of inventory slots
var slots: Array = []       # This will store slot data (each slot = Dictionary or null)

func _init():
	# Resize the array immediately when the object is created.
	# This ensures the UI can safely read slots without out-of-bounds errors.
	slots.resize(size)


func add_item(item: Item, amount: int = 1):

	# 1️⃣ Try stacking first
	# Loop through every slot looking for:
	# - A non-empty slot
	# - Same item type
	# - Not already at max stack
	for slot in slots:
		if slot != null:
			if slot["item"] == item and slot["amount"] < item.max_stack:
				# Increase stack amount directly in the Dictionary
				slot["amount"] += amount
				
				# Notify anything listening (UI, hotbar) that data changed
				emit_signal("inventory_updated")
				
				return true  # Stop immediately after stacking

	# 2️⃣ If no stack found, find empty slot
	# Now we look for the first null slot to place a new stack
	for i in range(slots.size()):
		if slots[i] == null:
			
			# Each slot stores a Dictionary instead of a custom class.
			# This keeps it lightweight and flexible.
			slots[i] = {
				"item": item,
				"amount": amount
			}
			
			emit_signal("inventory_updated")
			return true  # Item successfully added

	# If we reach here, no stacking worked and no empty slot was found
	return false  # Inventory is full
