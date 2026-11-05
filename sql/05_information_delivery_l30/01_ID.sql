USE SCHEMA dv_lab.l30_id;

CREATE OR REPLACE VIEW dim1_customer AS 
SELECT hub.sha1_hub_customer AS dim_customer_key
     , sat.ldts              AS effective_dts
     , hub.c_custkey         AS customer_id
     , sat.rscr              AS record_source
     , sat.*     
  FROM dv_lab.l10_rdv.hub_customer hub
  JOIN dv_lab.l20_bdv.sat_customer_bv_curr_vw sat
    ON hub.sha1_hub_customer = sat.sha1_hub_customer;

CREATE OR REPLACE VIEW dim1_order AS 
SELECT hub.sha1_hub_order   AS dim_order_key
     , sat.ldts             AS effective_dts
     , hub.o_orderkey       AS order_id
     , sat.rscr             AS record_source
     , sat.*
  FROM dv_lab.l10_rdv.hub_order hub
  JOIN dv_lab.l20_bdv.sat_order_bv_curr_vw sat
    ON hub.sha1_hub_order = sat.sha1_hub_order;

CREATE OR REPLACE VIEW fct_customer_order AS
SELECT lnk.ldts              AS effective_dts     
     , lnk.rscr              AS record_source
     , lnk.sha1_hub_customer AS dim_customer_key
     , lnk.sha1_hub_order    AS dim_order_key
  FROM dv_lab.l10_rdv.lnk_customer_order lnk;
