create or replace trigger qc
  before create on database
  when(ora_dict_obj_owner = 'MU'
   and ora_dict_obj_type  = 'TABLE')

  declare
    v_min_number_words number := mu.qc_spec.min_number_words;
    
    
  begin
    
  
    if regexp_count(ora_dict_obj_name, '_') + 1 < v_min_number_words then
      raise_application_error (
        num => -20000,
        msg => 'Cannot create object');
    end if;
  end;