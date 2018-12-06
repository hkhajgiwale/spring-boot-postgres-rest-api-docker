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
    
