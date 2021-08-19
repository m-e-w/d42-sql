/*
 Title
 SLM - Software Components
 Description
 Generates a list of Software Components with license details / counts and EOS / EOL information.
 */
SELECT
    s.software_pk "Software ID",
    s.name "Software Name",
    INITCAP(s.software_type) "Software Type",
    INITCAP(s.category_name) "Software Category",
    s.licensed_count "Licensed Count",
    s.discovered_count "Discovered Count",
    v.vendor_pk "Vendor PK",
    v.name "Software Vendor",
    sweol.softwareeoleos_pk "EOL/EOS PK",
    sweol.eol "End of Life Date",
    sweol.eos "End of Service Date",
    sweol.version "EOL/EOS SW Version",
    softwarelicensemodel_pk "SWLCMOD PK",
    swlm.name "License Model",
    INITCAP(swlm.license_type) "License Type",
    ROUND(
        CASE
            WHEN s.discovered_count = 0 THEN NULL
            ELSE 100.0 * s.discovered_count / s.licensed_count
        END,
        4
    ) "CALC: License Consumption"
FROM
    view_software_v1 s
    LEFT JOIN view_vendor_v1 v ON v.vendor_pk = s.vendor_fk
    LEFT JOIN view_softwarelicensemodel_v1 swlm ON s.softwarelicensemodel_fk = swlm.softwarelicensemodel_pk
    LEFT JOIN view_softwareeoleos_v1 sweol ON s.software_pk = sweol.software_fk
ORDER BY
    s.name ASC