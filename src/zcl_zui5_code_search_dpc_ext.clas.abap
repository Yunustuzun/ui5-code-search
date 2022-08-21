class ZCL_ZUI5_CODE_SEARCH_DPC_EXT definition
  public
  inheriting from ZCL_ZUI5_CODE_SEARCH_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_EXPANDED_ENTITYSET
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ZUI5_CODE_SEARCH_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_expanded_entityset.

    DATA: lv_string TYPE zui5_search_string.


    CASE iv_entity_name.
      WHEN 'Output'.
*      WHEN 'DataModel'.

**        copy_data_to_ref( EXPORTING  is_data = lt_model
**                   CHANGING  cr_data = er_entityset ).

      WHEN OTHERS.
        RETURN.
    ENDCASE.

    DATA(ls_app) =  it_filter_select_options[ property = 'SearchString' ].
    lv_string = ls_app-select_options[ 1 ]-low.


    CHECK lv_string IS NOT INITIAL.

    DATA(lt_output) = zui5_code_searcher=>search_string( iv_string =  lv_string ) .
    copy_data_to_ref( EXPORTING  is_data = lt_output
                       CHANGING  cr_data =  er_entityset ).


**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_EXPANDED_ENTITYSET
**  EXPORTING
**    iv_entity_name           =
**    iv_entity_set_name       =
**    iv_source_name           =
**    it_filter_select_options =
**    it_order                 =
**    is_paging                =
**    it_navigation_path       =
**    it_key_tab               =
**    iv_filter_string         =
**    iv_search_string         =
**    io_expand                =
**    io_tech_request_context  =
**  IMPORTING
**    er_entityset             =
**    et_expanded_clauses      =
**    et_expanded_tech_clauses =
**    es_response_context      =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  ENDMETHOD.
ENDCLASS.
