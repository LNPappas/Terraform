# like an override file for a pre-written folder (in this case virtualMachine)
module "instance" { 
    source = "../../virtualMachine" 
    # change zone when apply virtualMachine
    zone = "us-east1-c" 
}

# will also create this instance in this zone at same time
module "instance_two" { 
    source = "../../virtualMachine" 
    # change zone when apply virtualMachine
    zone = "us-east1-b" 
}

#  will also create this bucket
module "bucket" {
    source = "../../bucket"
    bucket_name = "module-test-bucket"
}
