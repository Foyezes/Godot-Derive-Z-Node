# Godot Derive Z Node
Get the Z channel of a normal map from X & Y channels.
This node only works in Godot 4.2 onwards.
![image](https://github.com/user-attachments/assets/5fa60c3f-1130-469e-9a91-a17d02e97c51)


# Method
The node take X & Y as inputs and outputs the full normal map.

    vec3 deriveZ(float x_in, float y_in){
			
			vec2 normalXY = vec2(x_in * 2.0 - 1.0, y_in * 2.0 - 1.0);
			
			float z = sqrt(max(1.0 - dot(normalXY, normalXY), 0.0));
			
			vec3 normal = vec3(normalXY.x, normalXY.y, z);
			
			return normal;
		}
By default the normalization is set to `No`. You can normalize the result by selecting `Yes` if you need.

`Yes`

    =normalize(deriveZ(%s, %s)) * 0.5 + 0.5;
`No`

    =deriveZ(%s, %s) * 0.5 + 0.5;

This implementation gives users the flexibility to choose whether they need normalization, which is useful since sometimes you might want to skip normalization for performance if you know your inputs are already normalized or if perfect unit vectors aren't required.

# Installation

You can get it from the [Asset Store](https://godotengine.org/asset-library/asset/3650) in editor.
Or extract the zip file and copy the folder to your project. You'll need to restart the editor for the node to appear in visual shader.
