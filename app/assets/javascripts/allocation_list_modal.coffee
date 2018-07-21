class AllocationListModal
  init: (e)->
    modal = $('#allocationListModal')
    receipt_tran_id = $(e.relatedTarget).data('receipt-tran-id')
    if receipt_tran_id
      modal.load "/allocations.js?q[receipt_tran_id_eq]=#{receipt_tran_id}", ->
        $('.receipt_no').hide()
    else
      invoice_tran_id = $(e.relatedTarget).data('invoice-tran-id')
      modal.load "/allocations.js?q[invoice_tran_id_eq]=#{invoice_tran_id}", ->
        $('.invoice_no').hide()

this.Accounts.allocationListModal = new AllocationListModal()