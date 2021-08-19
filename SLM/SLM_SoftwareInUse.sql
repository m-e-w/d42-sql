/*
 Title
 SLM - Software In Use
 Description
 Generates a list of Software In Use with EOL / EOS and device details.
 */
SELECT
    s.software_pk "Software PK",
    s.name "Software Name",
    INITCAP(s.software_type) "Software Type",
    INITCAP(s.category_name) "Software Category",
    siu.softwareinuse_pk "SoftwareInUse PK",
    siu.version "Software Version",
    siu.install_date "Installation Date",
    siu.install_path "Installation Path",
    v.vendor_pk "Vendor PK",
    v.name "Software Vendor",
    sweol.softwareeoleos_pk "EOL/EOS PK",
    sweol.eol "End of Life Date",
    sweol.eos "End of Service Date",
    sweol.version "EOL/EOS SW Version",
    d.device_pk "Device PK",
    d.name "Device Name",
    d.os_name "Operating System",
    d.os_version "OS Version",
    CASE
        WHEN siu.version <= sweol.version
        AND CURRENT_DATE >= sweol.eol THEN 'True'
        ELSE 'False'
    END AS "CALC: EOL",
    CASE
        WHEN siu.version <= sweol.version
        AND CURRENT_DATE >= sweol.eos THEN 'True'
        ELSE 'False'
    END AS "CALC: EOS"
FROM
    view_softwareinuse_v1 siu
    LEFT JOIN view_software_v1 s ON s.software_pk = siu.software_fk
    LEFT JOIN view_vendor_v1 v ON v.vendor_pk = s.vendor_fk
    LEFT JOIN view_softwareeoleos_v1 sweol ON s.software_pk = sweol.software_fk
    LEFT JOIN view_device_v2 d ON siu.device_fk = d.device_pk
ORDER BY
    s.name ASC