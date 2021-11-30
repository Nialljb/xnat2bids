README.md

This is currently under construction (Nov 2021)
*Please copy to local directory and update paths if running to avoid conflicts

Dependencies
- requires installation of py2.7 env 
- This env needs to have jupyter kernal setup
- pyxnat package installed
- jq installed (pip)

*Known issues*
- File structures/paths changed on xnat causing issues
    - This may result in altered versions based on projects
    - i.e. those with prefix Study__ 
- Update to py3.7 in process
- If submitting as job make sure env is sourced (to ensure dependencies are called i.e. jq)