# xnat2bids

* The bids function are in the dependencies directory on the cluster. If this is in you path (added to .bash_profile) then they can be called by just typing

         bids_1_preproc -i projectName 

## Steps
1. Run xnat downloader script to pull project data into the imaging directory. 
2. bids_1_preproc - unzip and label correctly at project level in raw directory. 
3. bids_2_proc - arrange in bids format in combined sourcedirectory.

* Requires an indexing file in order to match CIF numbers, scan sessisons etc. I have added these to an indexFiles directory for a number of compleated projects. This can be updated through xnat data client (XDC) with new data. However this will need to be set up locally and can be a bit of a pain. Alternativly it may be possible to to manually download this from the xnat site. 

## CIF_config.json
For all new aquisition types, this needs to be added into the config file in order to be collected and ordered correctly. 
For exmaple if I start collecting a new functional scan called "learningCurves" I need to add this and label it as being a functional task. 

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
