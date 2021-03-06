class AllocationModal
  init: (e)->
    modal = $('#allocationModal')
    receipt_tran_id = $(e.relatedTarget).data('id')

    modal.load "/allocations/new.js?receipt_tran_id=#{receipt_tran_id}", ->
      $('.fill_allocation_amount').click ->
        button = $(this)
        input = button.closest('.input-group').find('input')
        invoice_to_alloc = $(this).data('toAlloc')
        receipt_to_alloc = $('#receipt_to_alloc').data('toAlloc')
        available = receipt_to_alloc - (current_alloc() - Number(input.val()))
        to_alloc = Math.min(invoice_to_alloc, available)
        input.val(to_alloc)

      $('#autoallocate').click ->
        $('.allocation_amount_input').val(null)
        $('.allocation_amount_input').each ->
          input = $(this)
          invoice_to_alloc = input.data('toAlloc')
          receipt_to_alloc = $('#receipt_to_alloc').data('toAlloc')
          available = receipt_to_alloc - (current_alloc() - Number(input.val()))
          to_alloc = Math.min(invoice_to_alloc, available)
          if to_alloc >= 0.01
            input.val(to_alloc).change()

      $('.allocation_amount_input').change ->
        val = parseFloat $(this).val()
        allocated = parseFloat $(this).data('allocated')
        not_alloc_out = $(this).data('outamount') - allocated
        not_alloc_out = if not_alloc_out < 0 then 0.0 else not_alloc_out
        vatable_amount = val - not_alloc_out
        vatable_amount = if vatable_amount < 0 then 0.0 else vatable_amount
        vat = vatable_amount - (vatable_amount * 100.0 / (100 + parseFloat($(this).data('vatperc'))))
        total_vat = parseFloat($(this).data('vat-allocated')) + vat

        tr = $(this).closest('tr')
        vat_elem = tr.find('.vat')
        vat_elem.text $.number(total_vat, 2)

        to_alloc = $(this).data('to-alloc') - val
        tr.find('.to-alloc').text $.number(to_alloc, 2)

        allocated = allocated + val
        tr.find('.allocated').text $.number(allocated, 2)

        total_allocated_elem = $('.total-allocated')
        orig_allocated = Number(total_allocated_elem.data('allocated'))
        total_allocated_elem.text $.number(orig_allocated + current_alloc(), 2)

        to_alloc_elem = $('#receipt_to_alloc')
        receipt_to_alloc = Number to_alloc_elem.data('toAlloc')
        to_alloc_elem.text $.number(receipt_to_alloc - current_alloc(), 2)

current_alloc = ->
  sum = 0
  for el in $('.allocation_amount_input')
    sum += Number($(el).val())
  sum

this.Accounts.allocationModal = new AllocationModal()