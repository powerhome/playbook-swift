# Playbook

# Intro

## What is this?
Playbook-apple is the SwiftUI version of [Playbook](https://playbook.powerapp.cloud/), optimizing Playbook's designs for iOS & macOS native apps. Playbook is the first design system built for both Rails & React interfaces, & with playbook-apple, all of its design components are now replicated for Apple's systems. Playbook-apple is built & maintained by the iOS Development Team and User Experience Team at [Power Home Remodeling](https://www.techatpower.com/), the largest home remodeler in the US.   
    
## Goal?
To keep Playbook's design system identical across all platforms, updating playbook-apple as necessary to ensure standardization. As Playbook continuously evolves, playbook-apple will evolve with it. 


# Getting Started

## How to use this package in my application
(to do)

## Opening the package in Xcode

### Make sure you have the playbook-apple repo (clone it if you do not).
### To open the package in Xcode, there are 2 ways to go about this. EITHER:
1) Go to the playbook-swift directory in terminal and type:  xed .

**or** 

2) Drag the playbook-swift to the Xcode icon

## Resolve Package Dependencies 

### Right click (or ctrl click) on "Package Dependencies" on file navigation area (left side). 
Click "resolve package versions" :
https://cloud.powerhrg.com/s/DYTMQPSp6c3WHNw
    
### Build the package (command b). 

## Previewing the Kits   
 
### 1. Once build is successful, to see previews, be sure that the build target is on an iPhone:
To the left of "Build Succeeded" at the top of the window, there may be 
        Playbook -> My Mac.
        My Mac is the default, so click it and choose an iPhone of your choice.
        (You can always change this later). 
        https://cloud.powerhrg.com/s/RZbPpMPJGAwcDdR
        
### 2. Opening the kits to see the previews.
Be sure to click open the specific kit from the files on the left-hand side in order to preview it in the UI.
Sources -> Playbook -> any folder (aside from Assets)
https://cloud.powerhrg.com/s/dgBZyD5Rfd3tNLp

## Troubleshooting

### **IF** building the package fails:
    
a) go to the top left: Xcode:
        https://cloud.powerhrghttps://cloud.powerhrg.com/s/mj6fi7WkXrjS7HR
        
b) click Preferences
        
c) click on the tiny arrow next to /Xcode/DerivedData (make sure you are under the Locations tab):
        https://cloud.powerhrg.com/s/Ltw3z4cf9moaWSr
        
d) completely delete DerivedData folder. Then go back to step 3 (resolve package versions):
        https://cloud.powerhrg.com/s/SToDqG5jAC9AZ3d
        
### **IF** there isn't a preview of the UI of the selected kit, click Resume.
https://cloud.powerhrg.com/s/zNNzLDAMDcQDJQY


# How to Contribute
First, be sure you can run the package to make edits and see previews (See above).

# File Structure

## Colors
Colors are in Playbook -> Assets -> "Colors" AND there is a SwiftUI file extension called "Color" that shows how colors are used and can be used


