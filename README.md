# Failed to create IOSurface image (texture) - ios10OpenGLVideoRenderingBug

This repo reproduces a bug.
### Hardware
tested on iPhone 6, running ios10.0.0

### Issue
using openGL (instead of Metal) for rendering a Scene Kit scene doesn't work when the material is using a video texture (passed through a Sprite Kit scene)

### Reproduction
- run on a real device that supports Metal
- build the latest version that uses opengl (or use that [tag reference](https://github.com/gsabran/ios10OpenGLVideoRenderingBug/tree/opengl-fail)), you should see nothing. The logs should be:

```
scnView renderingAPI is metal false
scnView renderingAPI is opengl true
Failed to create IOSurface image (texture)
```

- checkout the previous commit (or use that [tag reference](https://github.com/gsabran/ios10OpenGLVideoRenderingBug/tree/metal-works)) It only changes the rendering to Metal, which you can also do through the Storyboard interface
- build it. You should see a cube with a video playing on top. The logs should be:

```
scnView renderingAPI is metal true
scnView renderingAPI is opengl false
```
