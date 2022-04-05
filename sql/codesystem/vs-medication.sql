-- Medication Valueset
-- This is the primary medication valueset used in the main hospital medication system
-- combines 4 different codesystems into the one

DROP TABLE IF EXISTS fhir_trm.vs_medication;
CREATE TABLE fhir_trm.vs_medication(
    system      VARCHAR NOT NULL
);

INSERT INTO fhir_trm.vs_medication (system)
VALUES
    ('http://fhir.mimic.mit.edu/CodeSystem/medication-formulary-drug-cd')
    , ('http://fhir.mimic.mit.edu/CodeSystem/medication-name')
    , ('http://fhir.mimic.mit.edu/CodeSystem/medication-mix')
    , ('http://fhir.mimic.mit.edu/CodeSystem/medication-poe-iv')