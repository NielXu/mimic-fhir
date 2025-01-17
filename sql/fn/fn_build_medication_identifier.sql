CREATE OR REPLACE FUNCTION fhir_etl.fn_build_medication_identifier(ndc VARCHAR(25), drug VARCHAR(255))
  returns jsonb
  language 'plpgsql'
as
$$
declare
    medication_identifier jsonb;
begin
    SELECT  
       '['                                                                          
        || CASE WHEN ndc IS NOT NULL AND ndc != '0' AND ndc != ''
            THEN jsonb_build_object(
                'system', 'http://mimic.mit.edu/fhir/mimic/CodeSystem/mimic-medication-ndc'
                , 'value', ndc
            )::text
            ELSE '' 
        END
        || CASE WHEN (ndc IS NOT NULL AND ndc != '0' AND ndc != '') AND drug != ''
                THEN ',' ELSE '' END
        -- drug name is never NULL, so just set the name here
        || CASE WHEN drug != ''  
            THEN jsonb_build_object(
                'system', 'http://mimic.mit.edu/fhir/mimic/CodeSystem/mimic-medication-name'
                , 'value', drug
            )::TEXT
           ELSE ''
        END
    
        || ']' AS output_value      
        
    INTO medication_identifier;       
    
    return medication_identifier;
end;
$$;
