# .tevapp format
A standard zip archive with the following structure, bold indicates required files or directories.
 - example.tevapp
     - **manifest.json**
     - server
         - scripts
         - scenes
         - images
         - meshes
         - audio
     - **client**
         - scripts
         - scenes
         - images
         - meshes
         - audio

# manifest.json
`name` defines a unique identifier used by the client and our website; when distributing your app, this name MUST be globally unique.

`networked` when true, the `server` folder becomes mandatory

`version` defines a version for your app 

## Permissions
You can toggle access to objects under the teverse namespace. If permissions is not set, an app is granted access to mostly everything under the teverse namespace. It is suggested that you only grant your apps access to singletons you use for security reasons.

By default, Teverse will grant apps access to interface, scene and disconnect, unless you explicitly deny these permissions.

# scripts
When your app is loaded, Teverse will search for a main.lua file and run it automatically if found. This is the main entry point to your app.