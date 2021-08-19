# d42-sql
(Unofficial) Device42 SQL query repository.

- [Changelog](#changelog)
- [SQL Queries](#sql-queries)
    - [Power and Environmental Monitoring](#power-and-environmental-monitoring)
    - [Software License Management](#software-license-management)

# Changelog
## Patch 0.01 | 2021-08-19
m-e-w: Updated SLM - Software In Use to return blank for calculated EOL/EOS bools if there is no EOL/EOS version associated with the package.

# SQL Queries
## Power and Environmental Monitoring
- [PEM - Time Series Data](./PEM/PEM_TimeSeries.sql)
## Software License Management
- [SLM - Software Components](./SLM/SLM_SoftwareComponents.sql)
- [SLM - Software In Use](./SLM/SLM_SoftwareInUse.sql)

