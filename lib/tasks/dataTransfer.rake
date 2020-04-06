require 'pg'
require 'csv'

namespace :dataTransfer do
    # Describe (desc) the next rake task
    desc "data transfer to postgresql"
    task transfer_for_factquotes: :environment do
        conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=mykeeouellet user=codeboxx password=Codeboxx1!");
        conn.exec("TRUNCATE TABLE factquotes RESTART IDENTITY")
        x = 1
        Quote.all.each do |quote|
            transfer_id = quote.id
            puts ("et une de fait! quote id")
            puts (quote.id)
            transfer_creation_date = quote.WorkingHours
            puts ("et une de fait! la date est mise")
            puts (transfer_creation_date)
            c = Customer.find_by_quote_id(quote.id)   
            transfer_business_name = c.company_name
            puts ("et une de fait! bob est ajouter")
            transfer_email = quote.email
            puts ("et une de fait! email")
            transfer_nb_elevator = quote.NbrElevators
            puts ("et une de fait! nb elevator")
            conn.prepare('statement'+x.to_s, 'insert into factquotes (quoteid, creation_date, business_name, email, nb_elevator) values ($1, $2, $3, $4, $5)')
            puts ("jai fait le prepare")
            puts('statement'+x.to_s)
            conn.exec_prepared('statement'+x.to_s, [ transfer_id, transfer_creation_date, transfer_business_name, transfer_email, transfer_nb_elevator ])
            puts ("et une de fait!")
            x = x + 1
        end
    end

    # migration des datas vers factcontact
    task transfer_for_factcontact: :environment do
        conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=mykeeouellet user=codeboxx password=Codeboxx1!");
        conn.exec("TRUNCATE TABLE factcontact RESTART IDENTITY")
        x = 1
        Lead.all.each do |leads|
            transfer_id = leads.id
            puts ("et une de fait! leads id")

            transfer_creation_date = leads.created_at
            puts ("et une de fait! la date est mise")

            transfer_business_name = leads.lead_company_name
            puts ("et une de fait! bob est ajouter")

            transfer_email = leads.lead_email
            puts ("et une de fait! email")

            transfer_project_name = leads.project_name
            puts ("et une de fait! nb elevator")

            conn.prepare('statement'+x.to_s, 'insert into factcontact (contactid, creation_date, business_name, email, project_name) values ($1, $2, $3, $4, $5)')
            puts ("jai fait le prepare")
            conn.exec_prepared('statement'+x.to_s, [ transfer_id, transfer_creation_date, transfer_business_name, transfer_email, transfer_project_name ])
            puts ("et une de fait!")
            x = x + 1
        end
    end
    # migration des datas vers factelevator
    task transfer_for_factelevator: :environment do
        conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=mykeeouellet user=codeboxx password=Codeboxx1!");
        conn.exec("TRUNCATE TABLE factelevator RESTART IDENTITY")
        x = 1
        Elevator.all.each do |elevators|
            transfer_serial_number = elevators.elevator_serial_number
            puts ("et une de fait! elevators id")

            transfer_creation_date = elevators.created_at
            puts ("et une de fait! la date est mise")

            c = Column.find(elevators.column_id) 
            b = Battery.find(c.battery_id) 
            b2 = Building.find(b.building_id) 
            transfer_building_id = b2.id

            c2 = Customer.find(b2.customer_id)
            transfer_customer_id = c2.id
            puts(transfer_customer_id)

            ad = Address.find_by_entity_id(b2.id) 
            puts(ad.city)

            transfer_city = ad.city
            puts ("et une de fait! city")

            conn.prepare('statement'+x.to_s, 'insert into factelevator (serialnumber, creation_date, buildingid, customerid, city) values ($1, $2, $3, $4, $5)')
            puts ("jai fait le prepare")
            conn.exec_prepared('statement'+x.to_s, [ transfer_serial_number, transfer_creation_date, transfer_building_id, transfer_customer_id, transfer_city ])
            puts ("et une de fait!")
            x = x + 1
        end
    end
    # migration des datas vers dimcustomers
    task transfer_for_dimcustomers: :environment do
        conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=mykeeouellet user=codeboxx password=Codeboxx1!");
        conn.exec("TRUNCATE TABLE dimcustomers RESTART IDENTITY")
        x = 1
        Customer.all.each do |customers|
            transfer_creation_date = customers.created_at
            puts ("et une de fait! la date est mise")

            transfer_business_name = customers.company_name
            puts ("et une de fait! bob est ajouter")

            transfer_contact_name = customers.company_contact_full_name
            puts ("et une de fait! email")

            transfer_contact_email = customers.company_contact_email
            puts ("et une de fait! nb elevator")


            quo  = Quote.find(customers.quote_id)
            transfer_nb_elevator = quo.NbrElevators 
            puts ("et une de fait! nb elevator")


            ad = Address.find_by_entity_id(customers.id) 
            transfer_city = ad.city
            puts ("et une de fait! city")

            conn.prepare('statement'+x.to_s, 'insert into dimcustomers (creation_date, business_name, contact_name, email, nb_elevator, city) values ($1, $2, $3, $4, $5, $6)')
            puts ("jai fait le prepare")
            puts('statement'+x.to_s)
            conn.exec_prepared('statement'+x.to_s, [ transfer_creation_date, transfer_business_name, transfer_contact_name, transfer_contact_email, transfer_nb_elevator, transfer_city ])
            puts ("et une de fait!")
            x = x + 1
        end
    end

    # seed factintervention table from csv file NOT WORKING!
    desc "CSV import to the table"
    task transfer_to_factintervention: :environment do

        conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=mykeeouellet user=codeboxx password=Codeboxx1!");
        conn.exec("TRUNCATE TABLE factintervention RESTART IDENTITY")
        filename = File.join Rails.root, "intervention_data.csv"
        CSV.foreach(filename, headers: true) do |row|

            factintervention = Factintervention.create!(employee_id: row["employee_id"], building_id: row["building_id"], battery_id: row["battery_id"], column_id: row["column_id"], elevator_id: row["elevator_id"], start_date_time_intervention: row["start_date_time_intervention"], end_date_time_intervention: row["end_date_time_intervention"], result: row["result"], report: row["report"], status: row["status"])
        end
    end
    # Call: rake dataTransfer:transfer_to_factintervention

    task codeboxx_employee: :environment do
        employee_firstname = ["Nicolas", "Nadya", "Martin","Mathieu", "Remi", "Mathieu", "Serge", "David", "Mathieu", "Thommas"]
        employee_lastname = ["Genest", "Fortier", "Chantal", "Houde", "Gagnon", "Lefrancois", "Savoie", "Boutin", "Lortie", "Carrier"]
        employee_function = ["Comm Rep", "Director", "Assistant director", "Captain", "Engineer", "Engineer", "Engineer", "Engineer", "Engineer", "Engineer"]
        employee_email = ["nicolas.genest@codeboxx.biz", "nadya.fortier@codeboxx.biz", "martin.chantal@codeboxx.biz ", "mathieu.houde@codeboxx.biz", "remi.gagnon@codeboxx.biz", "mathieu.lefrancois@codeboxx.biz", "serge.savoie@codeboxx.biz", "david.boutin@codeboxx.biz", "mathieu.lortie@codeboxx.biz", "thomas.carrier@codeboxx.biz"]
        i = 0
        10.times do
            employee= Employee.create(
                email: employee_email[i],
                firstname: employee_firstname[i],
                function: employee_function[i],
                lastname: employee_lastname[i]
            )
            i = i + 1
            employee.save!
        end
    end
# Call: rake dataTransfer:codeboxx_employee

# creation des tables en postgresql
task create_pg_table: :environment do
    conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=mykeeouellet user=codeboxx password=Codeboxx1!");
    conn.exec("
    CREATE TABLE factquotes(
        quoteid INT PRIMARY KEY,
        creation_date DATE NOT NULL,
        business_name VARCHAR (355) NOT NULL,
        email VARCHAR (355) NOT NULL,
        nb_elevator INT NOT NULL
     );
     CREATE TABLE factcontact(
        contactid INT PRIMARY KEY,
        creation_date DATE NOT NULL,
        business_name VARCHAR (355) NOT NULL,
        email VARCHAR (355) NOT NULL,
        project_name VARCHAR (355) NOT NULL
     );
     CREATE TABLE factelevator(
        serialnumber INT PRIMARY KEY,
        creation_date DATE NOT NULL,
        buildingid INT NOT NULL,
        customerid INT NOT NULL,
        city VARCHAR (355) NOT NULL
     );
     CREATE TABLE dimcustomers(
        creation_date DATE NOT NULL,
        business_name VARCHAR (355) NOT NULL,
        contact_name VARCHAR (355) NOT NULL,
        email VARCHAR (355) NOT NULL,
        nb_elevator INT NOT NULL,
        city VARCHAR (355) NOT NULL
     );
     CREATE TABLE factintervention (
         employee_id INT NOT NULL, 
         building_id INT NOT NULL, 
         battery_id INT, 
         column_id INT, 
         elevator_id INT, 
         start_date_time_intervention TIMESTAMP NOT NULL, 
         end_date_time_intervention TIMESTAMP, 
         result VARCHAR (355) NOT NULL, 
         report VARCHAR (355), 
         status VARCHAR (355) NOT NULL);
     ")
    end
    # Call: rake dataTransfer:create_pg_table
end