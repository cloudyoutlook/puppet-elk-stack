class elk
(
  $prefered_packages_list = ["java-1.8.0-openjdk","elasticsearch"],
  $server_user = "root"
)
{
  # Includes
  include elk::install
}

