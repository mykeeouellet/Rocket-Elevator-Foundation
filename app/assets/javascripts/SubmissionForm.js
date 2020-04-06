$( document ).ready(function(){
    $(".building_type").hide();

    $("#mySelect").change(function(){
        $(".building_type").hide();
        $("#"+ $(this).val()).show();
    });
  });
  
function MySelection() {
    var x = document.getElementById("mySelect");
    var i = x.selectedIndex;
    
    return i;
}

/* Functions that add the fields of the submission form according 
the choice in the drop-down menu (Res., Com., Corp., or Hybrid) 
according to the respective parameters of the calculation of the Nbr of Elevators.
*/
function Call()  {
    SelectedType();
}

function SelectedType()  {

    var service =  MySelection();  
    
    if ( service == 1 )
    {
    ResultNbrResidentialElevators(); 
    }
    
    if ( service == 2 )
    {
    ResultNbrCommercialElevators(); 
    
    }
    
    if ( service == 3 )
    {
    ResultNbrCorporateElevators(); 
    }
    
    if ( service == 4 )
    {
    ResultNbrHybridElevators(); 
    }
}

//Residential Nbr of Elevators formula//
function ResultNbrResidentialElevators() {

    var x = document.getElementById("NbrApartment").value || 0 ;
    var y = document.getElementById("NbrFloorResidential").value || 0 ;
    var z = document.getElementById("NbrBasementResidential").value || 0;

    /* Divide the number of apartments by the number of floors (excluding the number of basements) to
    obtain an average of doors per floor and require an elevator shaft for every 6 apartments. */
    var Nbr = Math.ceil(x / (y * 6) ); 
    /*A new column is added to each new group of 20 stories and thus double the number of elevator shafts*/     
    var column =  Math.ceil(y / 20);
    var NbrElevators = Nbr*column;

    if (x != 0  && y != 0   && z  != 0  )
    {document.getElementById("ResultElevator").value= NbrElevators;}
    else {
            document.getElementById("ResultElevator").value = 0;
            }
    console.log(NbrElevators)
    return NbrElevators;
    
    }
    
//Commercial Nbr of Elevators formula//
function ResultNbrCommercialElevators() {
    var c5 =   document.getElementById ("NbrParkingCommercial").value || 0 ;
    var  b =   document.getElementById ("NbrBasementCommercial").value || 0 ;
    var  f =   document.getElementById ("NbrFloorCommercial").value 	|| 0 ;
    var  c4 =   document.getElementById ("NbrSeparateBusinessCommercial").value ||  0 ;

    //The estimated number of cages is equal to the number required --> x //
    var x = document.getElementById("NbrElevatorCage").value || 0;
 
 if (c5 != 0  && b != 0   && f  != 0  &&  c4 != 0)
  {document.getElementById("ResultElevator").value = x;}
 else {
     document.getElementById("ResultElevator").value = 0;
     }
     return x;
}												


//Corporate Nbr of Elevators formula//
function ResultNbrCorporateElevators() {
    service = MySelection();
    
    var Fc =  document.getElementById("NbrFloorCorporate").value  || 0 ;
    var F = parseInt(document.getElementById("NbrFloorCorporate").value || 0  );
    
    var Bc =   document.getElementById("NbrBasementCorporate").value;
    var B = parseInt(document.getElementById("NbrBasementCorporate").value || 0 );
    
    var M = document.getElementById("NbrMaxOccupantCorporate").value || 0 ;
    var P = document.getElementById("NbrParkingCorporate").value || 0 ;
    var H = document.getElementById("NbrActivityHour").value || 0 ;
    var R = document.getElementById("NbrTenant").value || 0 ;
    
    /* Multiply the number of occupants per floor by the number of floors ( including the number of basements) 
    to obtain the total number of occupants divided by 1000. */
    var Nbr = Math.ceil( M*(F+B)/1000 ); 
    /* The number of stories ( including the number of basements) is divided by 20 to obtain the number of elevator columns required. */
    var column =  Math.ceil((F+B)/20);
    /* The total number of elevators is determined by the number of elevators divided by the number of columns. */
    var NbrResultElevatorsByCol =  Math.ceil(Nbr / column);
    
    var NbrElevators = NbrResultElevatorsByCol * column;        
    console.log(service);
    
         document.getElementById("ResultElevator").value = NbrElevators;  
    
    return NbrElevators;
    
    }
// Hybrid Nbr of Elevators formula//
function ResultNbrHybridElevators() {
    service = MySelection();
    
    var Fc =  document.getElementById("NbrFloorHybrid").value  || 0 ;
    var F = parseInt(document.getElementById("NbrFloorHybrid").value || 0  );
    
    var Bc =   document.getElementById("NbrBasementHybrid").value;
    var B = parseInt(document.getElementById("NbrBasementHybrid").value || 0 );
    
    var M = document.getElementById("NbrMaxOccupantHybrid").value || 0 ;
    var SB = document.getElementById("NbrSeparateBusinessHybrid").value || 0 ;
    var P = document.getElementById("NbrParkingHybrid").value || 0 ;
    var H = document.getElementById("NbrActivityHour").value || 0 ;
    var R = document.getElementById("NbrTenant").value || 0 ;
    
    /* Multiply the number of occupants per floor by the number of floors ( including the number of basements) 
    to obtain the total number of occupants divided by 1000. */
    var Nbr = Math.ceil( M*(F+B)/1000 ); 
    /* The number of stories ( including the number of basements) is divided by 20 to obtain the number of elevator columns required. */
    var column =  Math.ceil((F+B)/20);
    /* The total number of elevators is determined by the number of elevators divided by the number of columns. */
    var NbrResultElevatorsByCol =  Math.ceil(Nbr / column);
    
    var NbrElevators = NbrResultElevatorsByCol * column;        
    console.log(service);
    
         document.getElementById("ResultElevator").value = NbrElevators;  
    
    return NbrElevators;
    
    }

/* Unit price elevator and installation cost put either Residential or Commercial on ResulNbrResidentialElevators () */

function Price()  {
    var service = MySelection();
    
    if (service == 1)  {
    var NbrCorporateElevators = ResultNbrResidentialElevators();
                                       }
    if (service == 2)  {
    var NbrCorporateElevators = ResultNbrCommercialElevators();
                                       }									
    if (service == 3)  {
    var NbrCorporateElevators = ResultNbrCorporateElevators();
    }
    if (service == 4 )  {
        var NbrCorporateElevators = ResultNbrHybridElevators();
    
                                        }
    var PriceInstallElevators;							   
    var TotalCost;
    //STANDARD//
    if  (document.getElementById("PriceUnitStandard").checked) { 
    
    document.getElementById("PriceUnit").value="7565";
    PriceInstallElevators =  7565*0.1*NbrCorporateElevators;
    PriceInstallElevators =  PriceInstallElevators.toFixed(0);
    
    TotalCost = 7565*1.1*NbrCorporateElevators;
    TotalCost = TotalCost.toFixed(0);
                                    
    document.getElementById("InstallationCost").value = PriceInstallElevators;
    document.getElementById("TotalCost").value = TotalCost;
    } 
    //PREMIUM//
    if  (document.getElementById("PriceUnitPremium").checked)	{ 		               
    document.getElementById("PriceUnit").value="12345"; 
    PriceInstallElevators =  12345*0.13*NbrCorporateElevators;
    PriceInstallElevators =  PriceInstallElevators.toFixed(0);
    
    
    TotalCost = 12345*1.13*NbrCorporateElevators;
    TotalCost = TotalCost.toFixed(0);
                                  
    document.getElementById("InstallationCost").value = PriceInstallElevators ;
    document.getElementById("TotalCost").value = TotalCost;
    }
    //EXCELIUM//
    if  (document.getElementById("PriceUnitExcelium").checked)	{ 	
    
    document.getElementById("PriceUnit").value="15400"; 
    PriceInstallElevators =  15400*0.16*NbrCorporateElevators;
    PriceInstallElevators =  PriceInstallElevators.toFixed(0);
   
    
    TotalCost = 15400*1.16*NbrCorporateElevators;
    TotalCost = TotalCost.toFixed(0);
                                    
    document.getElementById("InstallationCost").value = PriceInstallElevators ;
    document.getElementById("TotalCost").value = TotalCost;
    }
}
