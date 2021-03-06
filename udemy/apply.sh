export PATH=$PATH:/opt

if [[ -z "$1" ]]; then
echo ""
echo "No Terraform path provided"
echo "SYNTAX = ./apply.sh <PATH>"
echo "EXAMPLE = ./apply.sh terraform/instance"
echo ""
exit
fi

terraform init $1
terraform get $1
terraform apply -auto-approve $1