# .tevapp format
A standard zip archive with the following structure, bold indicates required files or directories.
 - example.tevapp
     - **package.json**
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

# package.json
`name` defines a unique identifier used by the client and our website; when distributing your app, this name MUST be globally unique.

`networked` when true, the `server` folder becomes mandatory

`version` defines a version for your app 

# scripts
When your app is loaded, Teverse will search for a main.lua file and run it automatically if found. This is the main entry point to your app.