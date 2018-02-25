create or replace package qc_spec authid definer is
  type t_data_domain is record 
      (data_type   varchar2(10)
      ,length      number(4)
      ,precision   number(2));

  type t_arr_data_domain is table of t_data_domain
                            index by varchar2(10);
  
  min_number_words constant number := 2;
  
  arr_data_domain t_arr_data_domain;
end qc_spec;