@tool
extends MeshInstance3D

@export_flags_3d_render var render_layer: int

# Called when the node enters the scene tree for the first time.
func _ready():
	var mat = mesh.surface_get_material(0)
	mat.set_shader_parameter('view_tex', $WindowView.get_texture())
	$WindowView/Camera3D.cull_mask = render_layer
	set_child_visual_layer_recursive(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rect = get_viewport().size
	$WindowView.get_viewport().size = rect
	
	$WindowView/Origin.global_position = global_position
	$WindowView/Origin.global_rotation = global_rotation

func set_child_visual_layer_recursive(node: Node):
	var children = node.get_children(true)
	for c in children:
		if c.get_child_count(true) > 0:
			set_child_visual_layer_recursive(c)
		if c is VisualInstance3D:
			c.layers = render_layer
