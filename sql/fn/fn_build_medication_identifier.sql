CREATE OR REPLACE FUNCTION fn_build_medication_identifier(ndc VARCHAR(25), gsn VARCHAR(255), formulary_drug_cd VARCHAR(120), drug VARCHAR(255))
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
                'system', 'http://fhir.mimic.mit.edu/CodeSystem/medication-ndc'
                , 'value', ndc
            )::text
            ELSE '' 
        END 
        || CASE WHEN (ndc IS NOT NULL AND ndc != '0' AND ndc != '') AND (gsn IS NOT NULL AND gsn != '') 
                THEN ',' ELSE '' END
        || CASE WHEN gsn IS NOT NULL AND gsn != ''
            THEN jsonb_build_object(
                'system', 'http://fhir.mimic.mit.edu/CodeSystem/medication-gsn'
                , 'value', gsn
            )::text
            ELSE '' 
        END 
        || CASE WHEN ((ndc IS NOT NULL AND ndc != '0' AND ndc != '') OR (gsn IS NOT NULL AND gsn != '')) 
                       AND (formulary_drug_cd IS NOT NULL AND formulary_drug_cd != '') 
                THEN ',' ELSE '' END
        || CASE WHEN formulary_drug_cd IS NOT NULL AND formulary_drug_cd != ''
            THEN jsonb_build_object(
                'system', 'http://fhir.mimic.mit.edu/CodeSystem/medication-formulary-drug-cd'
                , 'value', formulary_drug_cd
            )::text
            ELSE '' 
        END 
        || CASE WHEN ((ndc IS NOT NULL AND ndc != '0' AND ndc != '') 
                        OR (gsn IS NOT NULL AND gsn != '') 
                        OR (formulary_drug_cd IS NOT NULL AND formulary_drug_cd != ''))
                        AND drug != ''
                THEN ',' ELSE '' END
        -- drug name is never NULL, so just set the name here
        || CASE WHEN drug != ''  
            THEN jsonb_build_object(
                'system', 'http://fhir.mimic.mit.edu/CodeSystem/medication-name'
                , 'value', drug
            )::TEXT
           ELSE ''
        END
    
        || ']' AS output_value      
        
    INTO medication_identifier;   
    
    
    return medication_identifier;
end;
$$;
