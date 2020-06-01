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
`name` defines an identifier used by the client and our website

`networked` when true, the `server` folder becomes mandatory

`version` defines a version for your app 