# Failed to create IOSurface image (texture) - ios10OpenGLVideoRenderingBug

This repo reproduces a bug.
### Hardware
tested on iPhone 6, running ios10.0.0

### Issue
using openGL (instead of Metal) for rendering a Scene Kit scene doesn't work when the material is using a video texture (passed through a Sprite Kit scene)

### Fix
- get rid of Sprite Kit that was used to get the video input and pass it to a Scene Kit node as a texture
- directly read the video frame buffer and pass it to a CALayer that can be used as texture input on a SceneKit Node

### Notes:
- This seems heavier on the CPU/GPU, and large video (4k) runs at very slow fps (~20fps)
