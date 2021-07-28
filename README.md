# EarthQuake

# Setup
This project currently doesn't require any additional setup and it should run as it is.

# Dependencies
Dependencies are handled by SwiftPackage. For the demonstration purposes project uses `SnapKit` 

# Architecture
Project uses MVVM-C architecture. 

# UI 
All views/viewControllers in project are created programatically. This makes easier to use constructor injection for ViewControllers and allows easier view modularization. In order to have a quick view preview without running the whole project I used UIViewPreview snippet (for more information please visit: https://nshipster.com/swiftui-previews/)

# Endpoint
Currently project calls the API using `http://`, which is not preferred by Apple and if possible should be switched to `https://` As a current workaround the domain has been added to exception domains.
