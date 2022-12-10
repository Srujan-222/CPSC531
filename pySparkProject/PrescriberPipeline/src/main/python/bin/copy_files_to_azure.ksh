############################################################
# Developed By:                                            #
# Developed Date:                                          # 
# Script Name:                                             #
# PURPOSE: Copy input vendor files from local to HDFS.     #
############################################################
  
# Declare a variable to hold the unix script name.
JOBNAME="copy_files_to_azure.ksh"

#Declare a variable to hold the current date
date=$(date '+%Y-%m-%d_%H:%M:%S')
bucket_subdir_name=$(date '+%Y-%m-%d-%H-%M-%S')

#Define a Log File where logs would be generated
LOGFILE="/home/srujan222/PycharmProjects/PrescriberPipeline/src/main/python/logs/${JOBNAME}_${date}.log"

###########################################################################
### COMMENTS: From this point on, all standard output and standard error will
###           be logged in the log file.
###########################################################################
{  # <--- Start of the log file.
echo "${JOBNAME} Started...: $(date)"

### Define Local Directories
LOCAL_OUTPUT_PATH="/home/srujan222/PycharmProjects/PrescriberPipeline/src/main/python/output"
LOCAL_CITY_DIR=${LOCAL_OUTPUT_PATH}/dimension_city
LOCAL_FACT_DIR=${LOCAL_OUTPUT_PATH}/presc

### Define SAS URLs
citySasUrl="https://prescpipelinenew.blob.core.windows.net/dimension-city/${bucket_subdir_name}?st=2022-12-09T02:38:50Z&se=2022-12-09T10:38:50Z&si=wrute&spr=https&sv=2021-06-08&sr=c&sig=fstjJkWUA9c6dgAdJeKEaNSS6kFifWbd6EMzaaPufi0%3D"
prescSasUrl="https://prescpipelinenew.blob.core.windows.net/presc/${bucket_subdir_name}?st=2022-12-09T02:42:19Z&se=2022-12-09T10:42:19Z&si=write&spr=https&sv=2021-06-08&sr=c&sig=wgBWH%2F3Wja4NUoRnG5vGePvdvkhQSYi75aL1VR9WkBo%3D"

### Push City  and Fact files to Azure.
azcopy copy "${LOCAL_CITY_DIR}/*" "$citySasUrl"
azcopy copy "${LOCAL_FACT_DIR}/*" "$prescSasUrl"

echo "The ${JOBNAME} is Completed...: $(date)"

} > ${LOGFILE} 2>&1  # <--- End of program and end of log.
