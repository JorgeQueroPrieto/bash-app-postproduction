# bash-app-postproduction
Bash app for fragment, code and group video.
This program uses gnu parallel tool to reduce execution time of video codec and trancodification, by distributing the workflow between the differents threads of the system.

Dependences:

- ffmpeg
- bc
- gnu parallel

Before executing:

1st) Copy the pristine video to the camera directory
2nd) Modify the main.sh "pristine" variable with the pristine video name plus extension
3rd) Modify the process.sh "codec", "extensionIn", "extensionOut" variables with your own preferences
4th) Modify the codify.sh "numeroNucleos" variable, depending of the total number of threads of your system
5th) Execute the main.sh file

*Each time you execute main.sh, all txt lists, logs, fragments, codified fragments and final video are removed for a clean execution. 

Notes:

- The extensions and codecs supported are the same which ffmpeg supports.
- This program was made on a Ubuntu 22.04 LTS system.
- install.sh bash script was made for auto install dependencies on amazon linux 2 ami
