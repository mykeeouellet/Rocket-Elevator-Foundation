$(document).ready(function() {
    // Default configuration of the page,  
    // all these <div> are hidden by default.
    $("#intervention_building_id").hide();
    $("#intervention_battery_id").hide();
    $("#intervention_column_id").hide();
    $("#intervention_elevator_id").hide();
    $("#intervention_submit").hide();

    // Building selector show/hide function
    $("#intervention_customer_id").change(function(){
        var customer_id = $('#customers_id').val();
        if(customers_id == 0){
            $("#intervention_building_id").hide();
        }else{
            $("#intervention_building_id").show();
          }
        // Ajax calling get_buildings and creating the dropdown selector
        $.ajax({
            url: "/interventions/get_buildings",
            method: "GET",  
            dataType: "json",
            data: {customer_id: customer_id},
            error: function (xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            },
            success: function (buildings) {
                console.log(buildings)
                $("#buildings_id").empty();

    
                $("#buildings_id").append('<option default value="0"> -- SELECT -- </option>');
                for(var i = 0; i < buildings.length; i++){
                    $("#buildings_id").append('<option value="' + buildings[i]["id"] + '">' +buildings[i]["id"] + '</option>');
                }
            }
        });
    });

    // Battery selector show/hide function
    $("#intervention_building_id").change(function(){
        var building_id = $('#buildings_id').val();
        console.log(building_id)
        if(buildings_id == null){
            console.log("Hiding Battery")
            $("#intervention_battery_id").hide();
            $("#intervention_submit").hide();
        } else{
            console.log("Showing battery")
            $("#intervention_battery_id").show();
            $("#intervention_submit").show();
        }
    // Ajax calling get_batteries and creating the dropdown selector
    $.ajax({
        url: "/interventions/get_batteries",
        method: "GET",
        dataType: "json",
        data: {building_id: building_id},
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (batteries) {
            console.log(batteries)
            $("#batteries_id").empty();

            $("#batteries_id").append('<option default value=""> -- SELECT -- </option>');
            for(var i = 0; i < batteries.length; i++){
                $("#batteries_id").append('<option value="' + batteries[i]["id"] + '">' +batteries[i]["id"] + '</option>');
            }
        }
    });
    });

    // Column selector show/hide function
    $("#intervention_battery_id").change(function(){
        console.log("function for columns begins here")
        var battery_id = $('#batteries_id').val();
        if(battery_id == null){
            $("#intervention_column_id").hide();
        } else{
            $("#intervention_column_id").show();
        }
    // Ajax calling get_columns and creating the dropdown selector
    $.ajax({
        url: "/interventions/get_columns",
        method: "GET",
        dataType: "json",
        data: {battery_id: battery_id},
        error: function (xhr, status, error) {
            console.log(columns)
            console.error('AJAX Error: ' + status + error);
        },
        success: function (columns) {
            console.log(columns)
            $("#columns_id").empty();

            $("#columns_id").append('<option default value=""> -- SELECT -- </option>');
            for(var i = 0; i < columns.length; i++){
                $("#columns_id").append('<option value="' + columns[i]["id"] + '">' +columns[i]["id"] + '</option>');
            }
        }
    });
    });

    // Elevator selector show/hide function
    $("#intervention_column_id").change(function(){
        var column_id = $('#columns_id').val();
        if(column_id == null){
            $("#intervention_elevator_id").hide();
        } else{
            $("#intervention_elevator_id").show();
        }
        // Ajax calling get_elevators and creating the dropdown selector
        $.ajax({
            url: "/interventions/get_elevators",
            method: "GET",
            dataType: "json",
            data: {column_id: column_id},
            error: function (xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            },
            success: function (elevators) {
                $("#elevators_id").empty();
    
                $("#elevators_id").append('<option default value=""> -- SELECT -- </option>');
                for(var i = 0; i < elevators.length; i++){
                    $("#elevators_id").append('<option value="' + elevators[i]["id"] + '">' + elevators[i]["id"] + '</option>');
                }
            }
        });
    });
});