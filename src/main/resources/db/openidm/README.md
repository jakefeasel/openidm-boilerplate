OpenIDM Repository Schema Creation Scripts
==========================================

This folder has the SQL scripts that are needed to create your OpenIDM repository. Included are the standard PostgreSQL scripts needed for initializing the repo, which probably shouldn't need to be updated unless you have some very specialized project needs (or if you don't want to use PostgreSQL). 

The one file you may be more interested in editing is the *custom_schema_optimizations.pgsql* file. This has indexes on the data structures which are used by the default OpenIDM UI, and are likely to need adjustment if you have a custom data model or different tuning needs.