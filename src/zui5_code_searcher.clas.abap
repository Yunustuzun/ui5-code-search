class ZUI5_CODE_SEARCHER definition
  public
  final
  create public .

public section.

  class-methods SEARCH_STRING
    importing
      !IV_STRING type ZUI5_SEARCH_STRING
    returning
      value(ET_OUTPUT) type ZUI5_CODE_SEARCH_OUTPUT_TT .
protected section.
private section.
ENDCLASS.



CLASS ZUI5_CODE_SEARCHER IMPLEMENTATION.


  METHOD search_string.

    DATA : ls_pagekey	   TYPE o2pagkey,
           lv_found_file,
           lt_files      TYPE zui5_code_files_tt,
           ls_output     TYPE zui5_code_search_output,
           ls_line       TYPE zui5_code_lines,
           lt_lines      TYPE zui5_code_lines_tt,
           lv_line_no    TYPE n.


    SELECT *
      FROM o2appl
      INTO TABLE @DATA(lt_o2appl)
      WHERE applname LIKE 'Z%'.

    LOOP AT lt_o2appl INTO DATA(ls_application).
      CLEAR ls_output.
      ls_output-applname = ls_application-applext.


      cl_o2_api_pages=>get_all_pages(
        EXPORTING
          p_applname     = ls_application-applname " O2 Application
          p_version      = ls_application-version " Version indicator (active/inactive)
*    p_mod_langu    =                  " Language Key (OBSOLETE !!!)
*    p_master_langu =                  " Language Key (OBSOLETE !!!)
*    p_with_texts   = 'X'              " 'X' -> Include Short Texts
        IMPORTING
          p_pages        = DATA(lt_pages) " Pages with Attributes
      ).


      CLEAR lt_files.
      LOOP AT lt_pages INTO DATA(ls_page).

        CLEAR lv_found_file..

        ls_pagekey-applname = ls_page-applname.
        ls_pagekey-pagekey  = ls_page-pagekey.

        cl_bsp_api_generate=>bsp_api_get_page(
          EXPORTING
            p_pagekey          =        ls_pagekey
          IMPORTING
*    p_pageattr         =                  " Page Attributes
             p_source           =      DATA(lt_source)    " Page Layout
*    p_ev_handler       =                  " Event handler
*    p_attributes       =                  " Page Attributes (Parameters)
*    p_typesource       =                  " Local Types of Page
          EXCEPTIONS
            permission_failure = 1                " No Authorization
            page_not_existing  = 2                " Page Already Exists (falls p_modify = ' ')
            error_occured      = 3                " Other (unexpected) error occurred
            OTHERS             = 4
        ).

        LOOP AT lt_source INTO DATA(ls_search).
          SEARCH ls_search-line FOR iv_string .
          IF sy-subrc IS INITIAL.
            lv_found_file = abap_true.
            EXIT.
          ENDIF.
        ENDLOOP.

        CHECK lv_found_file EQ abap_true.

        CLEAR : lv_line_no,lt_lines.
        LOOP AT lt_source INTO DATA(ls_source).
          ADD 1 TO lv_line_no..
          ls_line-applname = ls_page-author    .
          ls_line-mimetype = ls_page-mimetype.
          ls_line-pagename = ls_page-pagename.
          ls_line-line  = ls_source-line.
          ls_line-line_no = lv_line_no.

          APPEND ls_line TO lt_lines.
        ENDLOOP.

        APPEND VALUE #(
          applname    = ls_application-applname
          mimetype    = ls_page-mimetype
          author      = ls_page-author
          createdon   = ls_page-createdon
          changedby   = ls_page-changedby
          changedon   = ls_page-changedon
          pagename    = ls_page-pagename
          lines       = lt_lines
        ) TO lt_files.

      ENDLOOP.

      CHECK lt_files IS  NOT INITIAL.


      ls_output-files = lt_files.
      APPEND ls_output TO et_output.

    ENDLOOP.


  ENDMETHOD.
ENDCLASS.
