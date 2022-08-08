# xnat2bids
*Please copy to local directory and update paths if running to avoid conflicts

This is now a jupyer notebook that incorporates downloading from xnat, unziping files & curating into BIDS convention. The end result will be raw data under a project structure and currated data with a higher level structure as many participants are enrolled in multiple studies (sourcedata > CIFID > STUDYID)

*Dependencies*
- requires installation of py2.7 env 
- This env needs to have jupyter kernal setup
- pyxnat package installed
- jq installed (pip)

*Known issues*
- File structures/paths changed on xnat causing issues
    - This may result in altered versions based on projects
    - i.e. those with prefix Study__ 
- If submitting as job make sure env is sourced (to ensure dependencies are called i.e. jq)

## Steps
1. Run xnat downloader script to pull project data into the imaging directory. 
2. Download indexing files via XDC into /data/indexFiles/*
3. CIF_unzip: unzip and label correctly at project level in raw directory. 
4. bids_proc: arrange in bids format in combined sourcedirectory.

*Requires an indexing file in order to match CIF numbers, scan sessisons etc. I have added these to an indexFiles directory for a number of compleated projects. This can be updated through xnat data client (XDC) with new data. This should be incorporated into the notebook now. Feel free to check with me about this. 

#### Structure 

         /rds/general/project/c3nl_djs_imaging_data/live/data
         
         Inside data:
         /indexFiles/files*
         /raw/projects/sessions/data*
         /sourcedata/CIFIDs/sessions/scans/data*
         /derivatives/processedData*
         tbi_project_list.csv

Running the xnatDownloader notebook will download zipped data into the raw imaging directory with the project label given. In the imaging directory there is a folder called indexFiles. This needs to contain an indexing file, downloadable from xnat. From here CIF_unzip should run smoothly.. Check this output and all files have downloaded as expected. bids_proc can then be run which will format all the data in the bids format in the sourcedata directory with the CIF number as the participant ID and the session ID as the scan session. metaData containing the scan dates will be saved within each session directory. 


## CIF_config.json
For all new aquisition types, this needs to be added into the config file in order to be collected and ordered correctly. 
For example if I start collecting a new functional scan called "learningCurves" I need to add this and label it as being a functional task. Please don't edit directly in the dependencies directory. Copy from here first and check edit works before replacing dependency file. 

- dataType is the modality of scan (structural, functional etc.)  
- modality label is the name you want to assign the aquisition (t1, dti, rest, etc. )
- SeriesDescription is a string to match with the data comming off the scanner. 

### Example

        {
            "dataType": "func",
            "modalityLabel": "learningCurve",
            "criteria": {
                "SeriesDescription": "*learningCurves*"
            }
