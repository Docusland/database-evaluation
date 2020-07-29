SELECT * FROM owners as O 
    LEFT JOIN ownershousings as OH ON O.id = OH.idOwner 
    LEFT JOIN housings as H ON OH.idHousing = H.id 
    INNER JOIN type as T ON H.typeId = T.id 
    INNER JOIN address as A ON H.addressId = A.id
    LEFT JOIN housingsdetails as AD ON H.id = AD.idHousing
    LEFT JOIN status as ST ON AD.statusId = ST.id
    LEFT JOIN benefit as B ON AD.typePrestationId = B.id
    LEFT JOIN galleries as G ON AD.idHousing = G.idHousing
    WHERE O.lastName = 'Xavier' AND O.firstName = 'Niel' AND A.city = 'Calais'