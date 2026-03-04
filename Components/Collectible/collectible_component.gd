class_name CollectableComponent
extends Area2D

func _on_body_entered(body) -> void:
	if not body.has_node("InventoryData"):
		return
	
	var inventory = body.get_node("InventoryData")
	var item_holder = get_parent()
	
	if item_holder.item_data == null:
		return
	
	var added = inventory.add_item(item_holder.item_data, item_holder.quantity)
	
	if added:
		item_holder.queue_free()
