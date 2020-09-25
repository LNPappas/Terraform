export PATH=$PATH:/opt

if [[ -z "$1" ]]; then
echo ""
echo "No Terraform path provided"
echo "SYNTAX = ./plan.sh <PATH>"
echo "EXAMPLE = ./plan.sh terraform/instance"
echo ""
exit
fi

terraform init $1
terraform get $1
terraform plan -auto-approve $1