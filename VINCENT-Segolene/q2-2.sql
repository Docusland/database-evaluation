-- procedure 

CREATE OR REPLACE PROCEDURE gestionContactProprietaire
IS 
    contact proprietaires.contact%type;
    CURSOR curseurContact IS SELECT contact from proprietaires;
BEGIN 
    OPEN curseurContact
    loop
      FETCH curseurContact INTO contact;
      EXIT WHEN no_data_found;
      SELECT contact
      IF contact == null or contact == undefined
        contact = "mettre a jour";
      END IF;
    end loop;
    CLOSE curseurContact;
END;