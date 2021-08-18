/*
 Title
 SLM - Software Components
 Description
 Generates a list of Software Components with license details / counts and EOS / EOL information.
 Changelog
 Patch 0.01 | 2021-08-18
 m-e-w: Added EOL / EOS dates, EOL / EOS version and added INITCAP to license_type, software_type, category_name columns.
 */
SELECT
    s.software_pk "Software ID",
    s.name "Software Name",
    v.name "Software Vendor",
    swlm.name "License Model",
    INITCAP(swlm.license_type) "License Type",
    s.licensed_count "Licensed Count",
    s.discovered_count "Discovered Count",
    INITCAP(s.software_type) "Software Type",
    INITCAP(s.category_name) "Software Category",
    ROUND(
        CASE
            WHEN s.discovered_count = 0 THEN NULL
            ELSE 100.0 * s.discovered_count / s.licensed_count
        END,
        4
    ) "License Consumption",
    sweol.eol "End of Life Date",
    sweol.eos "End of Service Date",
    sweol.version "EOL/EOS SW Version"
FROM
    view_software_v1 s
    LEFT JOIN view_vendor_v1 v ON v.vendor_pk = s.vendor_fk
    LEFT JOIN view_softwarelicensemodel_v1 swlm ON s.softwarelicensemodel_fk = swlm.softwarelicensemodel_pk
    LEFT JOIN view_softwareeoleos_v1 sweol ON s.software_pk = sweol.software_fk