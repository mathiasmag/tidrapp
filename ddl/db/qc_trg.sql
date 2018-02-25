create or replace trigger qc_create_after
  after create on database
  when(ora_dict_obj_owner = 'MU'
   and ora_dict_obj_type  = 'TABLE')

  declare
    v_min_number_words number := mu.qc_spec.min_number_words;
    v_table_ok boolean := true;

  begin
    if regexp_count(ora_dict_obj_name, '_') + 1 < v_min_number_words then
      raise_application_error (
        num => -20000,
        msg => 'Cannot create object, table name is invalid');
    end if;

    for r in (select column_name
                    ,data_length
                    ,data_precision
                from all_tab_cols
               where owner      = ora_dict_obj_owner
                 and table_name = ora_dict_obj_name)
      loop
        -- Kolumnnamnet måste sluta med ett suffix som är ett av de definierade domänerna.
        if not mu.qc_spec.arr_data_domain.exists(substr(r.column_name
                                                       ,instr(r.column_name, '_', -1) + 1)
                                                ) then
          v_table_ok := false;
        end if;
      end loop;
      
    if not v_table_ok then
      raise_application_error (
        num => -20001,
        msg => 'Cannot create object, column name is invalid');
    end if;
  end;
/