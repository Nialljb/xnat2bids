# xnat2bids

* The bids function are in the dependencies directory on the cluster. If this is in your path (added to .bash_profile) then they can be called by just typing

         bids_1_preproc -i projectName 

## Steps
1. Run xnat downloader script to pull project data into the imaging directory. 
2. bids_1_preproc - unzip and label correctly at project level in raw directory. 
3. bids_2_proc - arrange in bids format in combined sourcedirectory.

* Requires an indexing file in order to match CIF numbers, scan sessisons etc. I have added these to an indexFiles directory for a number of compleated projects. This can be updated through xnat data client (XDC) with new data. However this will need to be set up locally and can be a bit of a pain. Alternativly it may be possible to to manually download this from the xnat site. Feel free to check with me about this. 

#### Structure 

         /rds/general/project/c3nl_djs_imaging_data/live/data
         
         Inside data:
         /indexFiles/files*
         /raw/projects/sessions/data*
         /sourcedata/cifIDs/sessions/scans/data*
         /derivatives/processedData*
         tbi_project_list.csv

Running the xnatDownloader notebook will download zipped data into the raw imaging directory with the project label given. In the imaging directory there is a folder called indexFiles. This needs to contain an indexing file, downloadable from xnat (some python lover might be able to do this as part of the downloader script - I have only managed this locally with XDC). From here bids_1_preproc should run smoothly.. Check this output and all files have downloaded as expected. bids_2_proc can then be run which will format all the data in the bids format in the sourcedata directory with the CIF number as the participant ID and the session ID as the scan session. metaData containing the scan dates will be saved within each session directory. 


## CIF_config.json
For all new aquisition types, this needs to be added into the config file in order to be collected and ordered correctly. 
For example if I start collecting a new functional scan called "learningCurves" I need to add this and label it as being a functional task. Please don't edit directly in the dependencies directoy. Download from here and check edit works before replacing dependency file. 

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
