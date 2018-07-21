class AllocationListModal
  init: (e)->
    modal = $('#allocationListModal')
    receipt_tran_id = $(e.relatedTarget).data('receipt-tran-id')
    params = {
      q: { receipt_tran_id_eq: receipt_tran_id }
    }
    modal.load "/allocations.js?q[receipt_tran_id_eq]=#{receipt_tran_id}", ->
      $('.receipt_no').hide()

this.Accounts.allocationListModal = new AllocationListModal()