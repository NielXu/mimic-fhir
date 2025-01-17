-- Medication name CodeSystem
-- Medication names from the pharmacy and prescriptions table, used when no other identifier is available

DROP TABLE IF EXISTS fhir_trm.cs_medication_name;
CREATE TABLE fhir_trm.cs_medication_name(
    code      VARCHAR NOT NULL
);

WITH medication_name AS (
    SELECT DISTINCT TRIM(REGEXP_REPLACE(medication, '\s+', ' ', 'g')) AS  code 
    FROM mimic_hosp.pharmacy
    
    UNION 
    
    SELECT 
        DISTINCT TRIM(REGEXP_REPLACE(medication, '\s+', ' ', 'g')) AS code
    FROM 
        mimic_hosp.emar_detail emd 
        LEFT JOIN mimic_hosp.emar em
            ON emd.emar_id = em.emar_id
)

INSERT INTO fhir_trm.cs_medication_name
SELECT code
FROM medication_name
WHERE 
    code IS NOT NULL 
    AND code != ''

