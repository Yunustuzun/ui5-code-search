*&---------------------------------------------------------------------*
*& Report ZUI5_CODE_SEARCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zui5_code_search.


DATA(lt_result) = zui5_code_searcher=>search_string( iv_string =  'ce Worker Registered' ).

BREAK-POINT.
*DATA : ls_pagekey  TYPE o2pagkey.
*
*
*
*SELECT *
*  FROM o2appl
*  INTO TABLE @DATA(lt_o2appl)
*  WHERE applname LIKE 'Z%'.
*
*LOOP AT lt_o2appl INTO DATA(ls_application).
*
*
*  cl_o2_api_pages=>get_all_pages(
*    EXPORTING
*      p_applname     = ls_application-applname " O2 Application
*      p_version      = ls_application-version " Version indicator (active/inactive)
**    p_mod_langu    =                  " Language Key (OBSOLETE !!!)
**    p_master_langu =                  " Language Key (OBSOLETE !!!)
**    p_with_texts   = 'X'              " 'X' -> Include Short Texts
*    IMPORTING
*      p_pages        = DATA(lt_pages) " Pages with Attributes
*  ).
*
*  LOOP AT lt_pages INTO DATA(ls_page).
*
*
*    ls_pagekey-applname = ls_page-applname.
*    ls_pagekey-PAGEKEY  = ls_page-pagekey.
*
*    cl_bsp_api_generate=>bsp_api_get_page(
*      EXPORTING
*        p_pagekey          =        ls_pagekey
*      IMPORTING
**    p_pageattr         =                  " Page Attributes
*         p_source           =      DATA(lt_source)    " Page Layout
**    p_ev_handler       =                  " Event handler
**    p_attributes       =                  " Page Attributes (Parameters)
**    p_typesource       =                  " Local Types of Page
*      EXCEPTIONS
*        permission_failure = 1                " No Authorization
*        page_not_existing  = 2                " Page Already Exists (falls p_modify = ' ')
*        error_occured      = 3                " Other (unexpected) error occurred
*        OTHERS             = 4
*    ).
*
*  ENDLOOP.
*ENDLOOP.
*
*CHECK sy-subrc IS INITIAL.
