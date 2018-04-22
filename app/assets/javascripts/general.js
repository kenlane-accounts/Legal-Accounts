function SetNominalVat(VatSel, PDoVatBit){

   var tNomUse='bank';
   if (VatSel.id.includes("sinv")) {
      tNomUse='nominalreceipt';
   }
   tNomUse='bank';
 
    // Get the Line No. we are dealing with ......
    var dnum=GetLineID(VatSel.id);


    //tranheads_nominal_trans_attributes_0_vatamount
    // Variables for each of the elements we need to update ........
    var damount = document.getElementById("tranheads_"+tNomUse+"_trans_attributes_"+dnum+"_tramount"); 
    var dnet = document.getElementById("tranheads_"+tNomUse+"_trans_attributes_"+dnum+"_netamount");
    var dvatsel = document.getElementById("tranheads_"+tNomUse+"_trans_attributes_"+dnum+"_vat_id"); 
    var dvat = document.getElementById("tranheads_"+tNomUse+"_trans_attributes_"+dnum+"_vatamount");
    
    damount.value=Number(damount.value).toFixed(2);

    dvat.value=Number(dvat.value).toFixed(2);

    // Do not do the VAT bit if we are coming from the VAT Amount -- Should be able to change this amount slightly ....
    if (PDoVatBit==true) {
        // Need to get the VAT % from the text of the selected VAT Rate
        var opt = dvatsel.options[dvatsel.selectedIndex].text;
        // This splits it into an array - we use element 1 ....
        var dperc = opt.split('-', 2);

        // Calculate the VAT ....
        var VATperc = (isNaN(dperc[1]) ? 0 : dperc[1]);
        VATperc = +100 + +VATperc;

        var netamt = (+damount.value / +VATperc)*100;

        netamt=Number(netamt).toFixed(2);

        var vatamt=damount.value-netamt;

        // Set the field with the VAT Value ....
        dvat.value=vatamt.toFixed(2);
    }
    // NET Value is always the amount less the vat amount -- => will always add together correctly then ....
    dnet.value = (damount.value-dvat.value).toFixed(2);
}


function SetINVNominalVat(VatSel, PDoVatBit){

   var tNomUse='pinv';
   if (VatSel.id.includes("sinv")) {
      tNomUse='sinv';
   }

    // Get the Line No. we are dealing with ......
    var dnum=GetLineID(VatSel.id);

    //tranheads_?inv_trans_attributes_0_vatamount
    // Variables for each of the elements we need to update ........
    var dnet = document.getElementById("tranheads_"+tNomUse+"_trans_attributes_"+dnum+"_netamount");
    var damount = document.getElementById("tranheads_"+tNomUse+"_trans_attributes_"+dnum+"_tramount"); 
    var dvatsel = document.getElementById("tranheads_"+tNomUse+"_trans_attributes_"+dnum+"_vat_id"); 
    var dvat = document.getElementById("tranheads_"+tNomUse+"_trans_attributes_"+dnum+"_vatamount");
    
    dnet.value=Number(dnet.value).toFixed(2);
    dvat.value=Number(dvat.value).toFixed(2);

    // Do not do the VAT bit if we are coming from the VAT Amount -- Should be able to change this amount slightly ....
    if (PDoVatBit==true) {
        // Need to get the VAT % from the text of the selected VAT Rate
        var opt = dvatsel.options[dvatsel.selectedIndex].text;
        // This splits it into an array - we use element 1 ....
        var dperc = opt.split('-', 2);
        
        // Calculate the VAT ....
        var vatamt = ((dnet.value/100)*dperc[1]);

        // Set the field with the VAT Value ....
        dvat.value=vatamt.toFixed(2);
    }

    damount.value = (+dnet.value + +dvat.value).toFixed(2);

    if (tNomUse=='sinv'){
        var dout = document.getElementById("tranheads_"+tNomUse+"_trans_attributes_"+dnum+"_outamount");
        damount.value = (+damount.value + +dout.value).toFixed(2);
    }
}

function GetLineID(attname){
    // Passed in the Id of 1 of the line items ....... We need to pull out the line no (23454578) associated E.G. : tranhead_trans_attributes_23454578_vat_id
    var numb = attname.match(/\d/g);
    numb = numb.join("");
    return numb;
}

