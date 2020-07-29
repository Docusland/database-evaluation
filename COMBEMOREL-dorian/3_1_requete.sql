/**
    3.1 Une requête qui permet de retourner l'ensemble des logements situés à Calais appartenant au propriétaire 'Xavier Niel'

*/

SELECT
a.number,
a.street,
a.zip,
a.city,
h.nb_unit,
h.nb_room,
h.surface,
h.tariff,
h.description,
h.reference,
h.energetic_performance,
h.ghg_emission,
t.name as type,
st.name as service_type,
s.status
fROM housing h
JOIN owner o on o.id = h.owner_id
JOIN address a on a.id = h.address_id
JOIN status s on s.id = h.status_id
JOIN type t on t.id = h.type_id
JOIN service_type st on st.id = h.service_type_id
WHERE a.city = "Calais"
AND o.first_name = "Niel"
AND o.last_name = "Xavier";