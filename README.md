# VST2 Default Folder Manager

 Unlike MacOS, Windows has no built in default folder for VST2 plugins. When installing a DAW that supports VST, the DAW generally should create and register VST2 folders for 32-bit and 64-bit plugins. Once registered, plugins should automatically install into these folders and any other audio software (DAWs, notation programs, audio editors) should find the plugins automatically with the default settings.

 Unfortunately, not all VST hosts properly create the required registry entries, and many users are not comfortable enough editing the registry themselves to correct this issue.

 The VST2 Default Folder Manager has two functions:
  - When run, it checks to see if the VST2 system registry was set up properly by a DAW. If it was not, it asks whether you want to create the recommended VST2 folders and register them. This can be useful before installing any VST hosts or VST2 plugins to make sure that everything will install into the correct locations by default without always having to override the VST path in the install wizard.
  - The main screen shows you what your VST2 32-bit and 64-bit paths are, and allows you to change the paths in your registry if you wish. Note that changing the path will not move the plugins - you will need to do that manually.
