# Godot4 Palette Limiter Example / Demo

This demo project tries to demonstrate methods to force or limit the colors of an image into a defined set of colors, or a palette. You may come to find that the project takes a long time to start up, this is expected. Some Key Take-aways from this are:
 * Processing takes a long time, and the shader is tremendously faster.
 * The Shader can smooth edges within smaller images that are being upscaled.
 * Both the Shader and RGB-Processing will fail to find the Purple Color in the second sample.
     * However using the HUE prioritization in the Processing panel will assign purple... also it takes a long long time.

## Requirements

 * Godot 4.2+

## Setup

1. Download/Open Godot
2. Download this project.
3. Locate this project using the Import or Scan function from the Godot Project Manager
4. Open this project, should be called "Palette"
5. Run the project by hitting `F5` or by pressing Play in the top right corner.

## How to Use

This is meant to be a learning tool. In that sense, I should have put more comments in the code. I didn't. That could change though!

You can adjust the Palette the shader uses by opening the `palette_limiter_mat.tres` Resource, then changing it's assigned texture in the Shader Parameters section at the Inspector on the right. Make sure to match the number of colors in the palette image to the `Num Colors` variable.

You can adjust which images are loaded, what colors are in the palette, and the Hue Threshold of the Processed method by opening the `play.tscn` Scene file. Then after selecting on the Processed node located at `Play/PanelContainer/Processed` wihtin the Heirarchy, it's settings will appear in the Inspector.

## Credits

 * The Shader was made by DrManatee at GodotShaders (https://godotshaders.com/shader/palette-limiter-shader/)
 * The Palette was made by GrafxKid at lospec (https://lospec.com/palette-list/sweetie-16)
 * pauldrewett helped me remember how math works at Forums.Godot (https://forum.godotengine.org/t/how-to-calculate-the-difference-between-two-values-that-wrap-around/106354/2)
