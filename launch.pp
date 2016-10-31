node default {

  class {
    "elasticsearch":
    # prefered_packages_list  => ["java-1.8.0-openjdk"],
    # other variables overriding defaults go here...
  }

  # Modules
  include java
  include elasticsearch
  include kibana

}
