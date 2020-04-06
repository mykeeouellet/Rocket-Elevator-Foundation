# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'json'
# include Faker
puts Dir.pwd
file = File.read(Dir.pwd+'/addresses.json')
jsonData = JSON.parse(file)
#puts jsonData["addresses"][0]["street_name"].inspect

# Seeding the leads table
p "Lead:"
100.times do
    lead = Lead.create(
        lead_full_name: Faker::Name.name,
        lead_company_name: Faker::Company.unique.name,
        lead_email: Faker::Internet.email,
        lead_phone: Faker::PhoneNumber.phone_number,
        project_name: Faker::Appliance.brand,
        project_description: Faker::Lorem.sentences(number: 1, supplemental: true),
        department_of_service: Faker::Company.industry,
        lead_message: Faker::Lorem.paragraphs(number: 1), 
        created_at: Faker::Time.between_dates(from: Date.today - 1, to: Date.today - 1000, period: :all),
    )
    puts lead.inspect
end

#seeding the users talbe
p "users:"
50.times do
    user = User.create!(
        email: Faker::Internet.email,
        encrypted_password: Faker::Crypto.md5,
        :confirmed_at => DateTime.now,
        sign_in_count: Faker::Boolean.boolean,
        failed_attempts: Faker::Boolean.boolean        
    )
    
    # user.skip_confirmation!
    user.save!
   
    puts user.inspect
end

#seeding the employees tables
users = User.take(50);
p "user query ===================================:"
puts users[0].id.inspect
p "employee:"
50.times do
    index = rand(0..49)
    employee= Employee.create(
        email: Faker::Internet.email,
        firstname: Faker::Name.first_name,
        function: Faker::Job.title,
        lastname: Faker::Name.last_name,
    )
    employee.save!
    puts employee.inspect
end   

#seeding the quote table
x=0
puts "quote:"
buildingType = ["Residential", "Commercial", "Corporate", "Hybrid" ]
elevatorQuality = ["Excelium", "Premium", "Standard"]
leads = Lead.take(20)
50.times do
    bt = rand(0..3)
    eq = rand(0..2)
    index = x
    l = rand(0..19)
    quote= Quote.create(
        BuildingType: buildingType[bt],
        NbrAppt: Faker::Number.between(from: 3, to: 50),
        NbrFloors: Faker::Number.between(from: 1, to: 100),
        NbrBassements: Faker::Number.non_zero_digit,
        NbrElevators: Faker::Number.between(from: 1, to: 12),
        ElevatorQuality: elevatorQuality[eq],
        ElevatorCost: Faker::Number.decimal(l_digits: 3, r_digits: 3),
        InstallationPrice: Faker::Number.decimal(l_digits: 3, r_digits: 3),
        TotalPrice: Faker::Number.decimal(l_digits: 3, r_digits: 3),
        NbrBusinesses: Faker::Number.between(from: 2, to: 15),
        NbrParking: Faker::Number.between(from: 1, to: 6),
        NbrRentalCompagnies: Faker::Number.between(from: 5, to: 60),
        NbrOccupanrtPerFloor: Faker::Number.between(from: 3, to: 50),
        WorkingHours: Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
        user_id:users[index].id,
        email: Faker::Internet.email,
        lead_id:leads[l].id
    )
    x+=1
    quote.save!
    puts quote.inspect
end

#seeding the customers table
x=0
addressStatus = ["Active", "Inactive"]
addressNotes = ["For residential", "For commercial", "For new client" ]
addressType = ["Billing", "Shiping", "Home", "Business"]
entityType =["Building", "Customer"]
quote = Quote.take(50)
puts "customer:"
50.times do
    index = x
    quoteindex = x
    customer = Customer.create(
        company_name: Faker::Company.unique.name,
        company_contact_full_name: Faker::Name.name,
        company_contact_email: Faker::Internet.email,
        company_contact_phone: Faker::PhoneNumber.phone_number,
        company_description: Faker::IndustrySegments.super_sector,
        service_technical_authority_full_name: Faker::Name.name,
        service_technical_authority_email: Faker::Internet.email,
        service_technical_authority_phone: Faker::PhoneNumber.phone_number,
        created_at: Faker::Time.between_dates(from: Date.today - 1, to: Date.today - 1000, period: :all),
        # updated_at:
        user_id: users[index].id,
        quote_id: quote[quoteindex].id
    )
    x+=1
    customer.save
     
    #seeding the addresses tables according to the entiti type customer
    puts customer.inspect
    if customer.persisted?
        at = rand(0..3)
        as = rand(0..1)
        an = rand(0..2)
        et = rand(0..1)
        indexAdress = rand(0..19)
        Address.create(
            address_type: addressType[at],
            address_status: addressStatus[as],
            street_number:  jsonData["addresses"][indexAdress]["street_number"],
            street_name: jsonData["addresses"][indexAdress]["street_name"],
            suite_or_apartment: jsonData["addresses"][indexAdress]["suite_or_apartment"],
            city: jsonData["addresses"][indexAdress]["city"],
            postal_code:jsonData["addresses"][indexAdress]["postal_code"],
            country:jsonData["addresses"][indexAdress]["country"],
            address_notes: addressNotes[an],
            entity: customer,
            latitude: jsonData["addresses"][indexAdress]["latitude"],
            longitude: jsonData["addresses"][indexAdress]["longitude"]



        )
    end 
end    

#seeding the buildings table
puts "Buildings:"
customer = Customer.take(50)
 20.times do
    index = rand(0...19)
    building = Building.create(
        building_administrator_full_name: Faker::Name.name,
        building_administrator_email: Faker::Internet.email,
        building_administrator_phone: Faker::PhoneNumber.phone_number,
        building_technical_contact_full_name: Faker::Name.name,
        building_technical_contact_email: Faker::Internet.email,
        building_technical_contact_phone: Faker::PhoneNumber.phone_number,
        customer_id: customer[index].id
    )
    building.save
   
    puts building.inspect

    #seeding the addresses table inccording to the entiy type building
    if building.persisted?
        at = rand(0..3)
        as = rand(0..1)
        an = rand(0..2)
        et = rand(0..1)
        indexAdress = rand(20..39)
        Address.create(
            address_type: addressType[at],
            address_status: addressStatus[as],
            street_number:  jsonData["addresses"][indexAdress]["street_number"],
            street_name: jsonData["addresses"][indexAdress]["street_name"],
            suite_or_apartment: jsonData["addresses"][indexAdress]["suite_or_apartment"],
            city: jsonData["addresses"][indexAdress]["city"],
            postal_code:jsonData["addresses"][indexAdress]["postal_code"],
            country:jsonData["addresses"][indexAdress]["country"],
            address_notes: addressNotes[an],
            entity: building,
            latitude: jsonData["addresses"][indexAdress]["latitude"],
            longitude: jsonData["addresses"][indexAdress]["longitude"]
            
        )
    end
    
 end    

 #seeding the buildingDetails table
information = ["Residential, built in 1985", "Commercial, built in 2000", "Corporate, built in 2001", "Hybrid, bult in 1998"]
valeur = ["Residential, 1983 for 500.000$", "Commercial, 1988 for 5.000.000$, ", "Corporate, 2000 for 50.000.000$ "]
building = Building.take(20)
20.times do
    build = rand(0..3)
    inf = rand(0..3)
    val = rand(0..2)
    BuildingDetail.create(
        information_key: information[inf],
        value: valeur[val],
        building_id: building[build].id
    )  
   
end    

#seeding the batterries table
buildType = ["Residential", "Commercial", "Corporate", "Hybrid"]
batteryStatus = ["On", "Off"]
batteryNotes = ["Defective", "Good for use"]
batteryInformation = ["Made in china", "New battery", "Made in Canada", "Old battery"]
building = Building.take(20)
employee = Employee.take(20)
20.times do
    btype = rand(0..3)
    bs = rand(0..1)
    bn = rand(0..1)
    build = [*1..20]
    binf = rand(0..3)
    emp = rand(0..19)
    batteries = Battery.create(
        building_type: buildingType[btype],
        battery_status: batteryStatus[bs],
        battery_commissioning_date: Faker::Date.between_except(from: 3.year.ago, to: 1.year.from_now, excepted: Date.today),
        battery_last_inspection_date: Faker::Date.between_except(from: 3.year.ago, to: 1.year.from_now, excepted: Date.today),
        battery_operation_certificate: Faker::SouthAfrica.vat_number,
        battery_information: batteryInformation[binf],
        battery_notes: batteryNotes[bn],
        # created_at:
        # updated_at:
        building_id: build.delete(build.sample),
        employee_id: employee[emp].id
    )
    batteries.save!
    puts batteries.inspect

    #seeding the columns table
    if batteries.persisted?
        buildingType = ["Residential", "Commercial", "Corporate"]
        columnStatus = ["In service" , "Out of serveice"]
        columnInformation = ["Brand new", "old", "Made in US", "Made in Canada"]
        colunmNotes = ["Defective", "Good for use"]
        
        rand(1..8).times do
            bt = rand(0..2)
            cols = rand(0..1)
            colInf=rand(0..3)
            colN = rand(0..1)
            columns = Column.create(
                building_type: buildingType[bt],
                served_floor_number: Faker::Number.between(from: 1, to: 20),
                column_status: columnStatus[cols],
                column_information: columnInformation[colInf],
                column_notes: colunmNotes[colN],
                # created_at
                # updated_at
                battery_id: batteries.id
            )    
            columns.save!
            puts columns.inspect
            puts "============================================="
            puts "              ALLO               "
            puts "=============================================="
            #seeding the elevators table
            if columns.persisted?
                elevatorModel =["Standard", "Premium", "Excelium"]
                buildingType = ["Residential", "Commercial", "Corporate"]
                elevatorStatus = ["Active", "Inactive", "Intervention"]
                elevatorInformation = ["Brand new", "Old", "Made in US", "Made in Canada", "in service since 4 years"]
                elevatorNotes = ["Out of service", "To be checked in a week", "The last inspection was successfull"]
                rand(1..12).times do
                    elm = rand(0..2)
                    build = rand(0..2)
                    els = rand(0..2)
                    elInf = rand(0..4)
                    elN = rand(0..2)
                    Elevator.create(
                        elevator_serial_number: Faker::Code.isbn,
                        elevator_model: elevatorModel[elm],
                        building_type:  buildingType[build],
                        elevator_status: elevatorStatus[els],
                        elevator_commissioning_date: Faker::Date.between_except(from: 3.year.ago, to: 1.year.from_now, excepted: Date.today),
                        elevator_last_inspection_date: Faker::Date.between_except(from: 3.year.ago, to: 1.year.from_now, excepted: Date.today),
                        elevator_inspection_certificate: Faker::SouthAfrica.vat_number,
                        elevator_information: elevatorInformation[elInf],
                        elevator_notes: elevatorNotes[elN],
                        created_at: Faker::Time.between_dates(from: Date.today - 1, to: Date.today - 1000, period: :all), 
                        # updated_at
                        column_id: columns.id
                    )
                end
            end
        end       
    end
end