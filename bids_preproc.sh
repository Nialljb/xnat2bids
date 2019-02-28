Usage() {
  cat <<EOF
    ___________ _   ____
   / ____|__  // | / / /
  / /     /_ </  |/ / /
 / /___ ___/ / /|  / /___
 \____//____/_/ |_/_____/

 Niall J. Bourke Imperial College London Feb 2019
 n.bourke@imperial.ac.uk


usage:  bids_preproc.sh -i <project_ID>

e.g. bids_preproc.sh -i DREAM

* This function assumes data has been downloaded with the xnat data downloader notebook.
* Ensure csv files with indexing information is in project folder

EOF
  exit 1
}

if [  $# -le 1 ];
  then
  Usage
  exit 1
 fi

while [ $# -ge 1 ];
do
  case "$1" in

		-i)
					project=$2;
					shift;;

  esac
  shift
done


  echo " Input job = $project "

wd=/rds/general/project/c3nl_djs_imaging_data/live/data/raw/
out=/rds/general/project/c3nl_djs_imaging_data/live/data/
cd ${wd}/${project}

for ii in `ls *.zip`; do

    # Gather labels
    study="$(echo $ii | cut -d'_' -f1)"
    scanner="$(echo $ii | cut -d'_' -f2)"
    sid="$(echo $ii | cut -d'_' -f3)"
    eid="$(echo $ii | cut -d'_' -f5)"

    SID="${scanner}_${sid}"
    EID="${scanner}_${eid}"

    # Loop over subject indexing file
    INPUT=${out}/indexFiles/${project}_subject.csv
    [ ! -f $INPUT] && {echo "$INPUT file not found"}

        while IFS="," read c1 c2 c3 c4 c5 c6
        do

        # Match data with index file
        if [[ $SID = $c1 ]]; then

        [[ -d $c3 ]] || mkdir $c3
        mv $ii $c3
        unzip $c3/$ii -d $c3
        cifid=$c3

        JSON='{"cif id": "'"$SID"'"}'
        printf '%s\n' "$JSON" >> $cifid/metaData.json
        fi
        done < $INPUT


    # Loop over experiment indexing file
    INPUT2=${out}/indexFiles/${project}_experiments.csv
    [ ! -f $INPUT2] && {echo "$INPUT file not found"}

        while IFS="," read c1 c2 c3 c4 c5 c6 c7 c8
        do
        # Match data with index file
        if [[ $EID = $c1 ]]; then
        JSON='{"'"$c6"'": "'"$c4"'"}'
        printf '%s\n' "$JSON" >> $cifid/metaData.json
        fi
        done < $INPUT2

echo "processed $cifid"
done

# Couldnt get this this to work to format json in a nice format
#JSON=\''{"'"$c6"'": "'"$c4"'"}'\' | python -m json.tool
