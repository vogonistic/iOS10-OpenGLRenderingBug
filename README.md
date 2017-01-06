# iOS 10 - can't use Sprite Kit in Scene Kit when using openGL

This repo reproduces a bug

### Hardware
 - iPhone 7 plus, running iOS 10
 - iPad Air 2, running iOS 10

### Issue
Using openGL (instead of Metal) for rendering a Scene Kit scene doesn't work when the material is a Sprite Kit scene as input. This works with Metal

### Reproduction
- run on a real device

Expected behavior is a cube with a video on it. Actual behavior is a black cube.
