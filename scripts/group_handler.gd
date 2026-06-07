extends Node

signal node_added_to_group(node: Node, group: StringName)
signal node_removed_from_group(node: Node, group: StringName)

enum Group {
	BEEPERS,
}

const GROUP_NAME_BY_GROUP_ENUM: Dictionary[Group, StringName] = {
	Group.BEEPERS : "beepers",
}


func add_node_to_group(node: Node, group: Group) -> void:
	node.add_to_group(GROUP_NAME_BY_GROUP_ENUM[group])
	node_added_to_group.emit(node, group)


func remove_node_from_group(node: Node, group: Group) -> void:
	node.remove_from_group(GROUP_NAME_BY_GROUP_ENUM[group])
	node_removed_from_group.emit(node, group)
