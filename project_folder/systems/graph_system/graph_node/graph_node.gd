extends Node2D

# VARIABLES

var resource:Resource = GraphMapNode.new()
var ChildNodes:Array  = []
var ParentNodes:Array = []

# NODES

onready var top_connector:Sprite    = $TopArrowConnector        # top connector
onready var bottom_connector:Sprite = $BottomCricleConnector    # bottom connector


func _ready() -> void:
	$Panel/TextureRect.texture = ImageUtilities.load_image(resource.graph_image_path)
	$Label.text                = resource.graph_node_name

func _physics_process(delta: float) -> void:
	if ChildNodes.empty():
		bottom_connector.visible = false
	else:
		bottom_connector.visible = true

	if ParentNodes.empty():
		top_connector.visible = false
	else:
		top_connector.visible = true

