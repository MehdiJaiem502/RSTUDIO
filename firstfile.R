
#Access to Cran BioConductor and Github
print("Package searching tool is R Documentation")
#PAckages Installation
install.packages("desired package name")
#Install packages from Bioconductor
source("https://bioconductor.org/bioclite.R")
biociLite("desired package name")
#Install packages from Github
install.packages("devtools")
library(devtools) #Load the devtool package
install_github("author/package")

#Which packages are installed
installed.packages() #or
library()

#UPDATE PACKAGES
#See which packages need and update
old.packages()
#Updates all packages that need an Update
update.packages() 
#updates a desired package
install.packages("desired package name") 

#REMOVE PACKAGES
#remove all installed packages
remove.packages()
#remove a desired package
remove.packages("desired package name")

#Check R Version
version
#Check R Version and all installed packages 
sessioInfo()

#HELP

helps(package= "desired package name")
