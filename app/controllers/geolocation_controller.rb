class GeolocationController < ApplicationController

    def sqlQuery()
      sql = "select b.building_administrator_full_name as nomadmin, 
                  b.building_technical_contact_full_name as nomtech, 
                  CONCAT(ad.street_number,' ',ad.street_name ,' ', ad.city ,' ',ad.postal_code,' ', ad.country )  as addresse,
                  ad.latitude latitude,
                  ad.longitude longitude,
                  bitem.nbbat,
                  bitem.nbcol,
                  bitem.nbelev
          from buildings b
          join addresses ad on ad.entity_id = b.customer_id
          join (
              select batitemcount.building_id, 
                  count(batitemcount.bat_id) nbbat, 
                  sum(batitemcount.nbcol) nbcol,
                  sum(batitemcount.nbelev) nbelev
              from (
                  SELECT bat.id bat_id, bat.building_id , 
                      count(col.id) nbcol,
                      (
                          select count(e.id) nbelev from `columns` c 
                          join elevators e on e.column_id  = c.id
                          where c.battery_id = bat.id
                          GROUP by c.battery_id
                      ) nbelev
                  from batteries bat 
                  join `columns` col on col.battery_id = bat.id 
                  GROUP by bat.id, bat.building_id 
              ) as batitemcount
              GROUP by batitemcount.building_id
          ) as bitem on bitem.building_id = b.id"
      return sql
    end 

    def executeQuery()
      
        results = ActiveRecord::Base.connection.execute(sqlQuery())
      
      if results.present? 
          rep =[]

        return results.as_json
      else
        return nil

        if results.present? 
            rep =[]
          return results.as_json
          else
            return nil
        end
      end
    end

  def index
    @hashResults = executeQuery() #execute la requete qui est plus haute
    @hashResults.inspect
    @hash = Gmaps4rails.build_markers(@hashResults) do |res, marker|


              marker.lat res[3]
              marker.lng res[4]
              marker.infowindow "<b>Administrator name:</b> "+ res[0]+"</br>"+"<b>Technician name: </b>"+res[1]+"</br>"+"<b>Address: </b>"+res[2]+"</br>"+"<b>Latitude: </b>"+ res[3]+"</br>"+"<b>Longitude: </b>"+ res[4]+"</br>"+"<b>Number of batteries: </b>"+ res[5].to_s+"</br>"+"<b>Number of columns: </b>"+ res[6].to_s+"</br>"+"<b>Number of elevators: </b>"+ res[7].to_s+"</br>"

    end
  end
end

