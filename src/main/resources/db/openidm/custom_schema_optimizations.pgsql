-- DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
--
-- Copyright (c) 2011-2014 ForgeRock AS. All rights reserved.
--
-- The contents of this file are subject to the terms
-- of the Common Development and Distribution License
-- (the License). You may not use this file except in
-- compliance with the License.
--
-- You can obtain a copy of the License at
-- http://forgerock.org/license/CDDLv1.0.html
-- See the License for the specific language governing
-- permission and limitations under the License.
--
-- When distributing Covered Code, include this CDDL
-- Header Notice in each file and include the License file
-- at http://forgerock.org/license/CDDLv1.0.html
-- If applicable, add the following below the CDDL Header,
-- with the fields enclosed by brackets [] replaced by
-- your own identifying information:
-- "Portions Copyrighted [year] [name of copyright owner]"


-- This script is used to optimize the default OpenIDM repository with the custom indexes that may be beneficial to your specific project; 
-- Run it after you have executed the 'createuser' and 'openidm' scripts. 

-- The default indexes shown below are designed to optimize the performance of the queries used in the default 
-- repo.jdbc.json file for PostgreSQL and the default schema, along with the default UI.

-- This file has to be executed by a user with SUPERUSER privileges, so that the extension can be created.
-- By default this is the 'postgres' user. For example: 

-- psql -U postgres openidm < custom_schema_optimization.sql


-- These btree indexes are great for sorting and exact matches.
CREATE UNIQUE INDEX idx_json_managedobjects_userName ON openidm.managedobjects 
    ( json_extract_path_text(fullobject, 'userName'), objecttypes_id );
CREATE INDEX idx_json_managedobjects_givenName ON openidm.managedobjects 
    ( json_extract_path_text(fullobject, 'givenName') );
CREATE INDEX idx_json_managedobjects_sn ON openidm.managedobjects 
    ( json_extract_path_text(fullobject, 'sn') );
CREATE INDEX idx_json_managedobjects_mail ON openidm.managedobjects 
    ( json_extract_path_text(fullobject, 'mail') );
CREATE INDEX idx_json_managedobjects_accountStatus ON openidm.managedobjects 
    ( json_extract_path_text(fullobject, 'accountStatus') );


-- this will guarantee that a given user isn't assigned the same role value more than once.
CREATE UNIQUE INDEX idx_json_managedobjectproperties_roles ON openidm.managedobjectproperties 
    ( managedobjects_id, (propKey LIKE '/roles/%'), propValue );


-- The PosgreSQL contrib extension 'pg_trgm' is needed to perform fast LIKE queries. Be sure you have installed
-- the 'postgresql-contrib' packages necessary to support it.

-- More info here http://www.depesz.com/2011/02/19/waiting-for-9-1-faster-likeilike/

create extension pg_trgm;

-- These "gin" indexes are great for performing LIKE operations. Use if you plan on doing
-- a lot of these types of queries. Below are some examples you might create if you are
-- using the default project schema with the default OpenIDM UI. Only enable these if you
-- need to perform the LIKE queries, otherwise you will incur a cost on creation with no
-- associated benefit.

CREATE INDEX idx_json_managedobjects_userName_gin ON openidm.managedobjects
  USING gin (json_extract_path_text(fullobject, 'userName') gin_trgm_ops);
CREATE INDEX idx_json_managedobjects_givenName_gin ON openidm.managedobjects 
  USING gin (json_extract_path_text(fullobject, 'givenName') gin_trgm_ops);
CREATE INDEX idx_json_managedobjects_sn_gin ON openidm.managedobjects 
  USING gin (json_extract_path_text(fullobject, 'sn') gin_trgm_ops);
CREATE INDEX idx_json_managedobjects_mail_gin ON openidm.managedobjects 
  USING gin (json_extract_path_text(fullobject, 'mail') gin_trgm_ops);
CREATE INDEX idx_json_managedobjects_accountStatus_gin ON openidm.managedobjects 
  USING gin (json_extract_path_text(fullobject, 'accountStatus') gin_trgm_ops);

