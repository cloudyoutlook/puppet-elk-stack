node default {

class {
    "elk":
    # prefered_packages_list  => ["java-1.8.0-openjdk"],
    # other variables overriding defaults go here...
  }

  # Modules
  include elk
}
