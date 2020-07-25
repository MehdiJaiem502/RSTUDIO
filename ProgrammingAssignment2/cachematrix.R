## Put comments here that give an overall description of what your
## functions do

## This functions will be used to create sub-functions that will be stored in a list.
##These sub-functions will help us create matrices, store them and being able to 
## call them. Likewise, the calculate inverse of the matrix can be stored and 
##displayed.

makeCacheMatrix <- function(x = matrix()) {
                inverse<-NULL
                
##1. 
                
##set is a function that changes the matrix stored in the main function.
##Useful in the only case where we want to change the matrix. Of course we have
##to be careful and initialize the inverse variable so that it corresponds to the
##inverse of the new matrix that we set.
        set <- function(y){
## "x <<- y" substitutes the matrix in x with the one in y the new input, in the main function makeCacheMatrix.
##A single use of "<-" substitutes the matrix "x" with "y" only in the set function
                x<<-y
                inverse<<-NULL
        }
        
        
#2. get the last stored matrix in 1.
        
        get<-function() x
        
        
## 3.

##setinv and getinv are functions similar to set and get. 
##Be careful though they don't calculate the mean.
##they simply store the value of the input in a variable into the main function makeCacheMatrix
## using (setinv) and return it using (getinv).        
        setinv<-function(inv)
        inverse<<- inv
        getinv<-function() inverse
        
        
## 4.
        
##creating a list to store all the functions created within makeCacheMatrix.
#Doing so lets as call the function with the "$" as list elements and use them.
        list(set=set,get=get,setinv=setinv,getinv=getinv)


}
## This function helps us calculate the inverse of the matrix.
##If the inverse is already store using the previous getinv function will display it
##Otherwise, the inverse value will be calculated and stored.

cacheSolve<- function(x) {
        inverse<<-x$getinv()
        data <- x$get()
        #row number
        p<-nrow(data)
        #column number
        l<-ncol(data)
        #calculates the determinant
        o<-det(data)
        #The following if-loop checks if the inverse was already cached or not
        #If not then calculates the inverse of the matrix and displays it.
        if((p = l) & (o!=0)){
                
        if  (!is.null(inverse)){
                message("getting cached data")
                return(inverse)
        }
        
        else{
                
        ## Return a matrix that is the inverse of 'x'
        
        inverse <<- solve(data)
        x$setinv(inverse)
        inverse
        }
        } 
        
        #The "else" warns the user that he used a non adequate matrix for this code
        else{
        message("ERROR MATRIX CHOICE: Your matrix has to be non singular and a square one")
        }
}





