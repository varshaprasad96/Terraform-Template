# Update to match the access key of the account
variable "access_key" {}


# Update to match the secret key of the account
variable "secret_key" {}

# Update to match the keyname which you would like to use to connect
# to the instance
variable "key_name" {}

# Update to match the path where you have the private key file (.pem file) present
variable "key_path" {}


# Update to the path where you have the /undertow folder present in your
# local system. The folder would have the java files which are to be present
# inside the instance to start the server and run the logic behind it.
# Example path : /Users/admin/Desktop/undertow-server
variable "input_file_path" {}

# Update this with the list containing the Subnet-Ids of region 1a and 1c
# Example = ["subnet-140f6448","subnet-d21e6bfc"]
variable "subnet_id" {type = "list"}
