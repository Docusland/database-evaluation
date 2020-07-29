SELECT AVG(AD.rate) FROM owners as O 
    LEFT JOIN ownershousings as OH ON O.id = OH.idOwner 
    LEFT JOIN housings as H ON OH.idHousing = H.id 
    LEFT JOIN housingsdetails as AD ON H.id = AD.idHousing
	LIMIT 1
    