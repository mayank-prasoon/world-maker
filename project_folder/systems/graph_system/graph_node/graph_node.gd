extends Node2D

# VARIABLES

var resource:Resource = GraphMapNode.new()
var ChildNodes:Array  = []
var ParentNodes:Array = []

var tier:int          = 0
var index:int         = 0

# NODES

onready var top_connector:Sprite    = $TopArrowConnector        # top connector
onready var bottom_connector:Sprite = $BottomCricleConnector    # bottom connector

# ------------------------------------------------------------------------------

class SortingSystem:
	static func sort_by_tier(a, b)->bool:
		if a.tier < b.tier:
			return true
		else:
			return false
	
	static func sort_by_parent_node_index(a, b)->bool:
		if a.ParentNodes.size() != 0 and b.ParentNodes.size() != 0:
			if a.ParentNodes[-1].index < b.ParentNodes[-1].index:
				return true
			else:
				return false
		else:
			return false

# ------------------------------------------------------------------------------

func _ready() -> void:
	$Panel/TextureRect.texture = ImageUtilities.load_image(resource.graph_image_path)
	$Label.text                = resource.graph_node_name

# ------------------------------------------------------------------------------

# physics process
func _physics_process(_delta: float) -> void:
	display_connector()
	assign_tier()

# ------------------------------------------------------------------------------

# assign position
func assign_tier()->void:
	self.tier = 0
	var node_postion = Vector2(0, 0)

	if ParentNodes.empty():
		self.tier = 0
	else:
		ParentNodes.sort_custom(SortingSystem, 'sort_by_tier')
		self.tier += ParentNodes[-1].tier + 1


	var tier_list  = []
	var child_nodes:Array = get_parent().get_children()
	child_nodes.sort_custom(SortingSystem, 'sort_by_parent_node_index')

	for nodes in child_nodes:
		if nodes.tier == self.tier:
			tier_list.append(nodes)
		index = tier_list.find(self)


	if ParentNodes.size() > 0:
		if self.index < ParentNodes[-1].index:
			self.index += ParentNodes[-1].index


	node_postion = Vector2((300 * index), 300 * tier)

	self.position = node_postion

# ------------------------------------------------------------------------------

# display connector
func display_connector() -> void:
	if ChildNodes.empty():
		bottom_connector.visible = false
	else:
		bottom_connector.visible = true

	if ParentNodes.empty():
		top_connector.visible = false
	else:
		top_connector.visible = true

# ------------------------------------------------------------------------------

func _on_Area2D_mouse_entered() -> void:
	pass

func _on_Area2D_mouse_exited() -> void:
	pass

# ------------------------------------------------------------------------------
