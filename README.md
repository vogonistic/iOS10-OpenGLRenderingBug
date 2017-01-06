# Failed to create IOSurface image (texture) - iOS 10 - can't use Sprite Kit in Scene Kit when using openGL

This repo reproduces a bug.
### Hardware
tested on iPhone 6, running ios10.0.0

### Issue
using openGL (instead of Metal) for rendering a Scene Kit scene doesn't work when the material is a Sprite Kit scene as input. This works with Metal

### Reproduction
- run on a real device

Expected behavior is a cube with a video on it. Actual behavior is a black cube.
