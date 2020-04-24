ROCKET ELEVATOR FOUNDATION

RSPEC Tests // Usage

You should run RSpec tests in the command line by using  
    
    bundle exec rspec --format documentation

This will test mainly three files (elevator_media_spec.rb/interventions_spec.rb/quotes_spec.rb).
All these files are located in the "spec" folder of the application. 

1.Zendesk API // Usage
This Api will be triggered each time an employee creates an intervention on 
the website. It will make a 'Ticket' with all the information the employee
enters on our Zendesk account for each intervention we receive.

To Use it will to first login to our Zendesk account.

    - URL : https://rocketelevators5361.zendesk.com/agent/welcome
    - Username : mykeeouellet@hotmail.com
    - Password : Mykee@123

Then you will need to sign-up as an employee on the rocket elevators
website to this url => http://rocketelevators.ca/employees/sign_up 
You will then be able to navigate to the dropdown menu under
the CONTACT section of the home page and select "Intervention Form". 

This will lead you there => (http://rocketelevators.ca/interventions/new).

To generate an intervention just fullfill the selectors and click create 
at the bottom of the form. Now you just need to navigate to the Zendesk 
panel and your newly created form will be there as a ticket.

2.REST API // Usage
To use the RestAPI you can use PostMan. It's very straight foward and I 
have provided to collection to all the query required this week.

    Postman Collection => https://www.getpostman.com/collections/1db0e8e9f80edeaf01c8
    RestAPI Github => https://github.com/mykeeouellet/restAPI
    RestAPI Azure url => https://rocketapimykee.azurewebsites.net/api/interventions

The 3 queries are described here: 

    TimeStamp format => "2020-03-16T21:32:29"

    1.GET => Returns all fields of all Service Request records that
    do not have a start date and are in "Pending" status.

    url => https://rocketapimykee.azurewebsites.net/api/interventions/status

    2.PUT => Change the status of the intervention request to
    "InProgress" and add a start date and time (Timestamp).

    url => https://rocketapimykee.azurewebsites.net/api/interventions/1

    3.PUT => Change the status of the request for action to
    "Completed" and add an end date and time (Timestamp).

    url => https://rocketapimykee.azurewebsites.net/api/interventions/1
