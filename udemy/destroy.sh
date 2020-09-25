export PATH=$PATH:/opt

if [[ -z "$1" ]]; then
echo ""
echo "No Terraform path provided"
echo "SYNTAX = ./destroy.sh <PATH>"
echo "EXAMPLE = ./destroy.sh terraform/instance"
echo ""
exit
fi

terraform init $1
terraform get $1
terraform destroy -auto-approve $1