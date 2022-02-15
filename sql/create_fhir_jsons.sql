\set outputdir '/tmp/mimic_output'
\! mkdir -p '/tmp/mimic_output'
\t

-- output mimic-fhir tables to json

-- institutional resources
\echo organization
\o :outputdir/organization.json
SELECT fhir FROM mimic_fhir.organization;

-- patient tracking resources
\echo patient
\o :outputdir/patient.json
SELECT fhir FROM mimic_fhir.patient;

\echo encounter
\o :outputdir/encounter.json
SELECT fhir FROM mimic_fhir.encounter;

\echo encounter_icu
\o :outputdir/encounter_icu.json
SELECT fhir FROM mimic_fhir.encounter_icu;

-- data resources: conditions, diagnoses, procedures
\echo condition
\o :outputdir/condition.json
SELECT fhir FROM mimic_fhir.condition;

\echo procedure
\o :outputdir/procedure.json
SELECT fhir FROM mimic_fhir.procedure;

\echo procedure_icu
\o :outputdir/procedure_icu.json
SELECT fhir FROM mimic_fhir.procedure_icu;

-- data resources: medications
\echo medication
\o :outputdir/medication.json
SELECT fhir FROM mimic_fhir.medication;

\echo medication_request
\o :outputdir/medication_request.json
SELECT fhir FROM mimic_fhir.medication_request;

\echo medication_dispense
\o :outputdir/medication_dispense.json
SELECT fhir FROM mimic_fhir.medication_dispense;

\echo medadmin
\o :outputdir/medadmin.json
SELECT fhir FROM mimic_fhir.medication_administration;

\echo medadmin_icu
\o :outputdir/medadmin_icu.json
SELECT fhir FROM mimic_fhir.medication_administration_icu;


\echo observation_labevents
\o :outputdir/observation_labevents.json
SELECT fhir FROM mimic_fhir.observation_labevents;

\echo observation_micro_org
\o :outputdir/observation_micro_org.json
SELECT fhir FROM mimic_fhir.observation_micro_org;

\echo observation_micro_susc
\o :outputdir/observation_micro_susc.json
SELECT fhir FROM mimic_fhir.observation_micro_susc;

\echo observation_micro_test
\o :outputdir/observation_micro_test.json
SELECT fhir FROM mimic_fhir.observation_micro_test;

\echo observation_chartevents
\o :outputdir/observation_chartevents.json
SELECT fhir FROM mimic_fhir.observation_chartevents;

\echo observation_datetimeevents
\o :outputdir/observation_datetimeevents.json
SELECT fhir FROM mimic_fhir.observation_datetimeevents;

\echo observation_outputevents
\o :outputdir/observation_outputevents.json
SELECT fhir FROM mimic_fhir.observation_outputevents;
