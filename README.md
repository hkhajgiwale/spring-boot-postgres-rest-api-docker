# spring-boot-postgres-rest-api-docker

There are multiple ways by which this API can be loaded

    # Requesting the existing application
    # Running the application by spinning up your own infrastructure
    # Spinnig up your own docker containers
    
   ## Requesting the exisiting application
      
    The application is up and we can check it at the URL: 
    
    To check the application directly make the use of API calls given in
    
   ## Running the application by spinning up your own infrastructure
   
    To check by spinning your own infrastructure, please move to the infrastructure_code folder and execute the following scripts in sequen
    
      a. sudo chmod +x *.sh
      b. ./terraform_plan.sh
      c. ./terrform_apply.sh
       
      Your application will start automatically. Please use the terraform binary that is uploaded here to avoid the conflicts. You can directly make use of the API calls as enlisted in the last REST Methods section 
   ## Spinnig up your own docker containers
   
    To setup own docker containers please follow the procedures as under:
    
      a. chmod +x boot_application.sh
      b. ./boot_application.sh
      
  

  ## REST API DOCUMENTATION
  
  1. Get all messages
    
            GET http://rest-docker.ml:8080/api/showMessages
        
  2. Get specific message by ID
        
            GET http://rest-docker.ml:8080/api/id/{id}
        
  3. Get specific message by name
        
            GET http://rest-docker.ml:8080/api/from/{message_from}
  4. Put the data
  
            POST http://rest-docker.ml:8080/api
        
            Payload
            {
                "messageFrom":"harsh",
                "messageDescription":"This is message 1"
            }
    
  5. Delete the data
        
            DELETE http://rest-docker.ml:8080/api/delete/{message_from}
 
 
 ## Using User Interface    
   
   1. Show all messages
   
   http://rest-docker.ml:8080/showMessages
   
   2. Add message
   
   http://rest-docker.ml:8080/addMessage
   
 
