#!/bin/bash
#
cd "${0%\/*}" 2>/dev/null || { echo -e "\x1B[31m[Error]\x1B[0m Unable to access directory ${0%\/*}"; exit  1; }

#export TF_LOG=trace #trace debug info
#export TF_LOG_PATH=.terraform/$1/terraform.log

function getEnvironments {
  e=$(ls -c1 ../env/ 2> /dev/null |tr "\n" "|")
  echo "^(${e%?})$" #get rid of last |
}

function usage {
  echo "Usage: $0 {apply|init|plan|destroy} {$(getEnvironments)}"
}

function set_data_dir {
  p="../env/${1}"
  mkdir -p "${p}" 2> /dev/null
  echo "${p}"
}
function init {
  p="../env/${1}"
  echo "export TF_DATA_DIR=$(set_data_dir "${1}/.terraform") && terraform init -var-file="${p}/terraform.tfvars" -backend-config="${p}/backend.conf""
  export TF_DATA_DIR=$(set_data_dir "${1}/.terraform") && terraform init -var-file="${p}/terraform.tfvars" -backend-config="${p}/backend.conf"
}
function plan {
  p="../env/${1}"
  echo "export TF_DATA_DIR=$(set_data_dir "${1}/.terraform") && terraform plan -var-file="${p}/terraform.tfvars""
  export TF_DATA_DIR=$(set_data_dir "${1}/.terraform") && terraform plan -var-file="${p}/terraform.tfvars"
}
function apply {
  p="../env/${1}"
  echo "export TF_DATA_DIR=$(set_data_dir "${1}/.terraform") && terraform apply -var-file="${p}/terraform.tfvars""
  export TF_DATA_DIR=$(set_data_dir "${1}/.terraform") && terraform apply -var-file="${p}/terraform.tfvars"
}
function destroy {
  p="../env/${1}"
  echo "export TF_DATA_DIR=$(set_data_dir "${1}/.terraform") && terraform destroy -var-file="${p}/terraform.tfvars""
  export TF_DATA_DIR=$(set_data_dir "${1}/.terraform") && terraform destroy -var-file="${p}/terraform.tfvars"
}
function main {

  [[ "${#}" -ne 2 ]] && { echo -e "\x1B[31m[Error]\x1B[0m Args ${#} < 2 ";    usage; exit 1; }
  [[ -e "../env" ]]  || { echo -e "\x1B[31m[Error]\x1B[0m No env found"; usage; exit 1; } 

  [[ "${1}" =~ init|plan|apply|destroy ]] || { echo -e "\x1B[31m[Error]\x1B[0m Unknown verb: ${1}"; usage; exit 1; }

  #check we will be using a exiting configuration folder
  [[ "${2}" =~ $(getEnvironments) ]] || { echo -e "\x1B[31m[Error]\x1B[0m Unknown env: ${2}"; usage; exit 1; }

  #At this point we have a defined environment and a proper acction to be executed
  #another ticket to the 7th circle
  "${1}" "${2}"
}

main "${@}"
