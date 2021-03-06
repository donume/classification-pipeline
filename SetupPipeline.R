#Setup Script
#Berk Ustun | ustunb@mit.edu | 2016

##### Setup Directories and Parse Command Line Arguments #####
cat(sprintf("Opened SetupPipeline.R in directory: %s\n", getwd()))
print_flag = TRUE;
source("StartUp.R");
args = commandArgs(TRUE);
command_line_flag = (length(args) > 0)
if (command_line_flag){
    comp_name = args[1];
    log_name = ifelse(length(args) > 1, args[2], NA);
} else {
    comp_name = "berkmac";
    log_name = ifelse(length(args) > 1, args[2], NA);
}

#set directories
fs = get.directories(comp_name);
home_dir = fs$home_dir;
R_dir = fs$R_dir;
results_dir = fs$results_dir;
data_dir = fs$data_dir;
raw_data_dir = fs$raw_data_dir;
log_dir = fs$log_dir;
lib_dir = fs$lib_dir;
rm(fs);

#logging
log_file = set.log(log_dir = log_dir, log_name = log_name);

#libraries
set.library(lib_dir, show_flag = print_flag);

#install required packages for pipeline
required_packages = c('dplyr',
                      'knitr',
                      'scales',
                      'ggplot2',
                      'stringr',
                      'formatR',
                      'Hmisc',
                      'xtable',
                      'C50',
                      'rpart.plot',
                      'ROCR',
                      'lubridate',
                      'gtools',
                      'rpart',
                      'C50',
                      'gbm',
                      'glmnet',
                      'randomForest',
                      'e1071');

installed_packages = installed.packages()[,1];
installed_idx = required_packages %in% installed_packages;
required_packages = required_packages[!installed_idx];
installed_all_packages = all(installed_idx);

attempt = 0;
max_attempts = 5;
while (!installed_all_packages){

    #check if all packages have been installed properly
    install.packages(pkgs = required_packages, lib = lib_dir);
    installed_packages = installed.packages()[,1]
    installed_idx = required_packages %in% installed_packages;
    installed_all_packages = all(installed_idx);
    required_packages = required_packages[!installed_idx];

    #keep track of # of attempts and break loop to prevent hanging
    if (attempt >= max_attempts){
        break;
    } else {
        attempt = attempt + 1;
    }
}

cat(sprintf("Finished running SetupPipeline.R in directory: %s\n", getwd()));
quit("no")



