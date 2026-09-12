CLASS zcl_gdm_matreq DEFINITION PUBLIC FINAL.

  PUBLIC SECTION.
    INTERFACES: if_workflow.

    DATA: mv_reqid  TYPE zgdm_matreq-reqid    READ-ONLY,
          mv_matnr  TYPE zgdm_matreq-matnr    READ-ONLY,
          mv_ernam  TYPE zgdm_matreq-ernam    READ-ONLY,
          mv_status TYPE zgdm_matreq-status   READ-ONLY.

    METHODS: constructor
      IMPORTING iv_reqid TYPE zgdm_matreq-reqid.

    EVENTS: created.
    EVENTS: completed.

ENDCLASS.



CLASS ZCL_GDM_MATREQ IMPLEMENTATION.


  METHOD bi_object~default_attribute_value.
    DATA: lv_text TYPE string.
    lv_text = |Solicitação { mv_reqid } - Material { mv_matnr }|.
    GET REFERENCE OF lv_text INTO result.
  ENDMETHOD.


  METHOD bi_object~execute_default_method.

  ENDMETHOD.


  METHOD bi_object~release.

  ENDMETHOD.


  METHOD bi_persistent~find_by_lpor.
    result = NEW zcl_gdm_matreq( CONV #( lpor-instid ) ).
  ENDMETHOD.


  METHOD bi_persistent~lpor.
    result-catid  = 'CL'.
    result-typeid = 'ZCL_GDM_MATREQ'.
    result-instid = mv_reqid.
  ENDMETHOD.


  METHOD bi_persistent~refresh.
    SELECT SINGLE matnr ernam status
      FROM zgdm_matreq
      INTO (mv_matnr, mv_ernam, mv_status)
      WHERE reqid = mv_reqid.
  ENDMETHOD.


  METHOD constructor.
    mv_reqid = iv_reqid.

    SELECT SINGLE matnr ernam status
      FROM zgdm_matreq
      INTO (mv_matnr, mv_ernam, mv_status)
      WHERE reqid = mv_reqid.
  ENDMETHOD.
ENDCLASS.
