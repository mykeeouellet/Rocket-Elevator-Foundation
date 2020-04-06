// /*Faire les formulaires residential, commercial, corporate et hybrid*/
		
// 			$(".residentialoptions").hide();
// 			$(".commercialoptions").hide();
// 			$(".corporateoptions").hide();
// 			$(".hybridoptions").hide();

// 			$( "#selector" ).change(function() {
// 				  console.log("this", this);
// 				  console.log("this.value", this.value);
// 				  if( this.value == "Residential") {
// 					$(".residentialoptions").fadeIn();
// 					$(".commercialoptions").fadeOut();
// 					$(".corporateoptions").fadeOut();
// 					$(".hybridoptions").fadeOut();
// 					$('.form-control').val('');
// 					if ( document.getElementById('standardResidential').checked = true) {
//                     document.getElementById('standardResidential').checked = false
//                     };
//                     if ( document.getElementById('premiumResidential').checked = true) {
//                     document.getElementById('premiumResidential').checked = false
//                     };  
//                     if ( document.getElementById('exceliumResidential').checked = true) {
//                     document.getElementById('exceliumResidential').checked = false
//                     };              
//                     }
// 					else if( this.value == "Commercial") {
// 					$(".residentialoptions").fadeOut();
// 					$(".commercialoptions").fadeIn();
// 					$(".corporateoptions").fadeOut();
// 					$(".hybridoptions").fadeOut();
// 					$('.form-control').val('');
// 					if ( document.getElementById('standardCommercial').checked = true) {
//                     document.getElementById('standardCommercial').checked = false
//                     };
//                     if ( document.getElementById('premiumCommercial').checked = true) {
//                     document.getElementById('premiumCommercial').checked = false
//                     };  
//                     if ( document.getElementById('exceliumResidential').checked = true) {
//                     document.getElementById('exceliumCommercial').checked = false
//                     };              
//                     }
// 				    else if( this.value == "Corporate") {
// 					$(".residentialoptions").fadeOut();
// 					$(".commercialoptions").fadeOut();
// 					$(".corporateoptions").fadeIn();
// 					$(".hybridoptions").fadeOut();
// 					$('.form-control').val('');
// 					if ( document.getElementById('standardCorporate').checked = true) {
//                     document.getElementById('standardCorporate').checked = false
//                     };
//                     if ( document.getElementById('premiumCorporate').checked = true) {
//                     document.getElementById('premiumCorporate').checked = false
//                     };  
//                     if ( document.getElementById('exceliumCorporate').checked = true) {
//                     document.getElementById('exceliumCorporate').checked = false
//                     };              
//                     }
// 				    else if ( this.value == "Hybrid") {
// 					$(".residentialoptions").fadeOut();
// 					$(".commercialoptions").fadeOut();
// 					$(".corporateoptions").fadeOut();
// 					$(".hybridoptions").fadeIn();
// 					$('.form-control').val('');
// 					if ( document.getElementById('standardHybrid').checked = true) {
//                     document.getElementById('standardHybrid').checked = false
//                     };
//                     if ( document.getElementById('premiumHybrid').checked = true) {
//                     document.getElementById('premiumHybrid').checked = false
//                     };  
//                     if ( document.getElementById('exceliumHybrid').checked = true) {
//                     document.getElementById('exceliumHybrid').checked = false
//                     };              
//                     }
// 				    else if ( this.value == "--- Select ---") {
// 					$(".residentialoptions").fadeOut();
// 					$(".commercialoptions").fadeOut();
// 					$(".corporateoptions").fadeOut();
// 					$(".hybridoptions").fadeOut();
// 				  };
				  
// 			});
		
		
// // Calcul residential
 

// 	function calculResidential(){
// 		var nbApp = document.getElementById("numberOfApartmentResidential").value || 0 ;
// 		var nbFloor = document.getElementById("numberOfFloorResidential").value || 0 ;
// 		var nbBasement = document.getElementById("numberOfBasementResidential").value || 0;
// 		var Nber = Math.ceil( nbApp /(nbFloor*6) ); 
		 
			   
// 		var colonne =  Math.ceil(nbFloor /20);
		  
// 		var  NberElevators = Nber*colonne;
// 		if (nbApp != 0  && nbFloor != 0   && nbBasement  != 0  ){
// 		document.getElementById("nbElevatorNeededResidential").value= NberElevators;
// 		} else {
// 				document.getElementById("nbElevatorNeededResidential").value = 0;
// 			    }
		
// 		if (document.getElementById("standardResidential").checked){
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostResidential").value = 7565;
// 			var installationCost = document.getElementById("installationCostResidential").value = Math.ceil (7565 * 0.1) * NberElevators;
// 			document.getElementById("totalCostResidential").value = (elevatorUnitCost * NberElevators)  + installationCost;
// 		}
// 	else if (document.getElementById("premiumResidential").checked){
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostResidential").value = 12345;
// 			var installationCost = document.getElementById("installationCostResidential").value = Math.ceil(12345 * 0.13) * NberElevators;
// 			document.getElementById("totalCostResidential").value = (elevatorUnitCost * NberElevators)  + installationCost;

// 			}
// 	else if (document.getElementById("exceliumResidential").checked){
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostResidential").value = 15400;
// 			var installationCost = document.getElementById("installationCostResidential").value = Math.ceil(15400 * 0.16) * NberElevators;
// 			document.getElementById("totalCostResidential").value = (elevatorUnitCost * NberElevators)  + installationCost;

// 			}
// 		}
		


// // Calcul commercial
// 	function calculCommercial(){
// 		var nbCage = document.getElementById("numberOfCageCommercial").value;
// 		document.getElementById("nbElevatorNeededCommercial").value = nbCage;
// 		if (document.getElementById("standardCommercial").checked){
// 			console.log("potaytooooooo");
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostCommercial").value = 7565;
// 			var installationCost = document.getElementById("installationCostCommercial").value = Math.ceil (7565 * 0.1) * nbCage;
// 			document.getElementById("totalCostCommercial").value = (elevatorUnitCost * nbCage)  + installationCost;
// 		}
// 	else if (document.getElementById("premiumCommercial").checked){
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostCommercial").value = 12345;
// 			var installationCost = document.getElementById("installationCostCommercial").value = Math.ceil (12345 * 0.13) * nbCage;
// 			document.getElementById("totalCostCommercial").value = (elevatorUnitCost * nbCage)  + installationCost;

// 			}
// 	else if (document.getElementById("exceliumCommercial").checked){
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostCommercial").value = 15400;
// 			var installationCost = document.getElementById("installationCostCommercial").value = Math.ceil (15400 * 0.16) * nbCage;
// 			document.getElementById("totalCostCommercial").value = (elevatorUnitCost * nbCage)  + installationCost;

// 			}
// 	}



// // Calcul corporate
// 	function calculCorporate(){
// 		/*pseudocode de brosse time!
// 		nb occupant X nb etage (incluant sous sol)= nb occupant total
// 		nb occupant total / 1000 = nb  elevator cage requis
// 		nb etage (incluant sous sol) / 20 = nb de colonnes requis
// 		nb elevator cage / nb colonne = nb total elevator
// 		*/
// 		var nbOccupantCorporate = parseInt(document.getElementById("numberOfOccupantCorporate").value);
// 		var nbFloorCorporate = parseInt(document.getElementById("numberOfFloorCorporate").value);
// 		var nbBasementCorporate = parseInt(document.getElementById("numberOfBasementCorporate").value);

// 		var nbTotalOccupantCorporate = nbOccupantCorporate * (nbFloorCorporate + nbBasementCorporate) ;
// 		var nbElevatorCageCorporate = nbTotalOccupantCorporate / 1000 ;
// 		var nbColonneCorporate = (nbFloorCorporate + nbBasementCorporate) / 20 ;
// 		var nbTotalElevatorCorporate = Math.ceil((nbElevatorCageCorporate / nbColonneCorporate) * nbColonneCorporate) ;
// 		document.getElementById("nbElevatorNeededCorporate").value = Math.ceil (nbTotalElevatorCorporate);

// 		if (document.getElementById("standardCorporate").checked){
// 			console.log("potaytooooooo");
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostCorporate").value = 7565;
// 			var installationCost = document.getElementById("installationCostCorporate").value =  ((7565 * 0.1) * nbTotalElevatorCorporate);
// 			document.getElementById("totalCostCorporate").value = Math.ceil (elevatorUnitCost * nbTotalElevatorCorporate)  + installationCost;
// 		}
// 	else if (document.getElementById("premiumCorporate").checked){
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostCorporate").value = 12345;
// 			var installationCost = document.getElementById("installationCostCorporate").value =  ((12345 * 0.13) * nbTotalElevatorCorporate);
// 			document.getElementById("totalCostCorporate").value = Math.ceil (elevatorUnitCost * nbTotalElevatorCorporate)  + installationCost;

// 			}
// 	else if (document.getElementById("exceliumCorporate").checked){
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostCorporate").value = 15400;
// 			var installationCost = document.getElementById("installationCostCorporate").value =  ((15400 * 0.16) * nbTotalElevatorCorporate);
// 			document.getElementById("totalCostCorporate").value = Math.ceil (elevatorUnitCost * nbTotalElevatorCorporate)  + installationCost;

// 			}
// 	}



// // Calcul hybrid
// 	function calculHybrid(){
// 		/*pseudocode de brosse time!
// 		nb occupant X nb etage (incluant sous sol)= nb occupant total
// 		nb occupant total / 1000 = nb  elevator cage requis
// 		nb etage (incluant sous sol) / 20 = nb de colonnes requis
// 		nb elevator cage / nb colonne = nb total elevator
// 		*/
// 		var nbOccupantHybrid = parseInt(document.getElementById("numberOfOccupantHybrid").value);
// 		var nbFloorHybrid = parseInt(document.getElementById("numberOfFloorHybrid").value);
// 		var nbBasementHybrid = parseInt(document.getElementById("numberOfBasementHybrid").value);
// 		var nbTotalOccupantHybrid = nbOccupantHybrid * (nbFloorHybrid + nbBasementHybrid) ;
// 		var nbElevatorCageHybrid = nbTotalOccupantHybrid / 1000 ;
// 		var nbColonneHybrid = (nbFloorHybrid + nbBasementHybrid) / 20 ;
// 		var nbTotalElevatorHybrid = Math.ceil((nbElevatorCageHybrid / nbColonneHybrid) * nbColonneHybrid) ;
// 		document.getElementById("nbElevatorNeededHybrid").value = Math.ceil (nbTotalElevatorHybrid)

// 		if (document.getElementById("standardHybrid").checked){
// 			console.log("potaytooooooo");
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostHybrid").value = 7565;
// 			var installationCost = document.getElementById("installationCostHybrid").value =  ((7565 * 0.1) * nbTotalElevatorHybrid);
// 			document.getElementById("totalCostHybrid").value = Math.ceil (elevatorUnitCost * nbTotalElevatorHybrid)  + installationCost;
// 		}
// 	else if (document.getElementById("premiumHybrid").checked){
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostHybrid").value = 12345;
// 			var installationCost = document.getElementById("installationCostHybrid").value =  ((12345 * 0.13) * nbTotalElevatorHybrid);
// 			document.getElementById("totalCostHybrid").value = Math.ceil (elevatorUnitCost * nbTotalElevatorHybrid)  + installationCost;


// 			}
// 	else if (document.getElementById("exceliumHybrid").checked){
// 			var elevatorUnitCost = document.getElementById("elevatorUnitCostHybrid").value = 15400;
// 			var installationCost = document.getElementById("installationCostHybrid").value =  ((15400 * 0.16) * nbTotalElevatorHybrid);
// 			document.getElementById("totalCostHybrid").value = Math.ceil (elevatorUnitCost * nbTotalElevatorHybrid)  + installationCost;

// 			}
// 	}

