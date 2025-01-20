# This node was created by Foyezes
# x.com/Foyezes
# bsky.app/profile/foyezes.bsky.social

@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeDeriveZ

func _get_name():
	return "DeriveZ"

func _get_category():
	return "Color"

func _get_description():
	return "Get the Z channel of a normal map from X & Y channels"

func _get_output_port_count():
	return 1
	
func _get_input_port_count():
	return 2

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_name(port):
		return "result"
			
func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_name(port):
	match port:
		0:
			return "x"
		1:
			return "y"
			
func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
			
func _get_property_count():
	return 1
	
func _get_property_name(index):
	match index:
		0:
			return "Normalized"
			
func _get_property_options(index):
	match index:
		0:
			return ["No(Default)", "Yes"]
			
func _get_global_code(mode):
	return """
		vec3 deriveZ(float x_in, float y_in){
			
			vec2 normalXY = vec2(x_in * 2.0 - 1.0, y_in * 2.0 - 1.0);
			
			float z = sqrt(max(1.0 - dot(normalXY, normalXY), 0.0));
			
			vec3 normal = vec3(normalXY.x, normalXY.y, z);
			
			return normal;
		}
	"""

func _get_code(input_vars, output_vars, mode, type):
	var normalize = get_option_index(0)
	match normalize:
		0:
			return output_vars[0] + "=deriveZ(%s, %s) * 0.5 + 0.5;" % [input_vars[0], input_vars[1]]
		1:
			return output_vars[0] + "=normalize(deriveZ(%s, %s)) * 0.5 + 0.5;" % [input_vars[0], input_vars[1]]
