from perintah.document_utils import (
    get_print_opd_id,
    get_matching_pemda,
    filter_spt_pelaksana,
)

def get_spt_print_context(pemberi_tugas):
    opd_id = get_print_opd_id(pemberi_tugas)

    pemda = get_matching_pemda(
        pemberi_tugas.penandatangan.opd
    )

    pelaksana_list = filter_spt_pelaksana(
        pemberi_tugas.spt.pelaksana.all(),
        pemberi_tugas.penandatangan.tugas,
        opd_id=opd_id,
        signatory_opd_id=getattr(
            pemberi_tugas.penandatangan,
            "opd_id",
            None,
        ),
    )

    return {
        "pemda": pemda,
        "pelaksana_list": pelaksana_list,
    }

def get_spt_print_context(pemberi_tugas):
    opd_id = get_print_opd_id(pemberi_tugas)

    pemda = get_matching_pemda(
        pemberi_tugas.penandatangan.opd
    )

    pelaksana_list = filter_spt_pelaksana(
        pemberi_tugas.spt.pelaksana.all(),
        pemberi_tugas.penandatangan.tugas,
        opd_id=opd_id,
        signatory_opd_id=getattr(
            pemberi_tugas.penandatangan,
            "opd_id",
            None,
        ),
    )

    return {
        "pemda": pemda,
        "pelaksana_list": pelaksana_list,
    }