create or replace package body qc_spec is
-- Paket utan body, det här är bara för att ha ett initieringsblock för saker 
-- som inte kan sättas i deklarationen i paketdefinitionen.
--
-- Mathias 15-03-14
begin
  -- declare inne i paketspecifikatonen bara för att deklarerade variabler skall
  -- scopas just till den. Det ger också ett begin inne i blocket. Lite overkill
  -- men lite renare och tydligare.
  declare   dd t_data_domain;
  begin
    -- kodifiering av definitionen av domäner. Se datadomain.txt.
    dd.data_type := 'VARCHAR2'; dd.length := 10; dd.precision := null;
    arr_data_domain('ID')       := dd;

    dd.data_type := 'NUMBER';   dd.length := 10; dd.precision := 0;
    arr_data_domain('KEY')      := dd;

    dd.data_type := 'VARCHAR2'; dd.length := 10; dd.precision := null;
    arr_data_domain('KEYALPHA') := dd;

    dd.data_type := 'NUMBER';   dd.length := 1;  dd.precision := 0;
    arr_data_domain('FLG') := dd;
  end;
end qc_spec;