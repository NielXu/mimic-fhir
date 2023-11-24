CREATE OR REPLACE FUNCTION fhir_etl.fn_prescriptions_medication_code(ndc VARCHAR(25), drug VARCHAR(255))
  returns jsonb
  language 'plpgsql'
as
$$
declare
    medication_code jsonb;
begin
    SELECT CASE                                                                   
        WHEN ndc IS NOT NULL AND ndc != '0' AND ndc != '' THEN
            jsonb_build_object(
                'system', 'http://mimic.mit.edu/fhir/mimic/CodeSystem/mimic-medication-ndc'  
                , 'code', ndc
            )::TEXT
        ELSE
            jsonb_build_object(
                'system', 'http://mimic.mit.edu/fhir/mimic/CodeSystem/mimic-medication-name'  
                , 'code', TRIM(REGEXP_REPLACE(drug, '\s+', ' ', 'g'))
            )::TEXT
        END AS output_value      
        
        
    INTO medication_code;   
    
    
    return medication_code;
end;
$$;
