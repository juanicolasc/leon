$( document ).on('turbolinks:load', function() {
  (function() {
      
/* for nested charges in sales*/
  //for edit
  $("select[name^='sale[charges_attributes]']").select2();
  $(".nested-fields").each(function () {
    add_change_listener($(this).children('select'),$(this).children('input[type="number"]'));
  });

      
  //for create
  $('#charges').on('cocoon:after-insert', function(e, inserted_item) {
    inserted_item.children('select').select2();
    add_change_listener(inserted_item.children('select'),inserted_item.children('input[type="number"]'));
    update_sale_data();
  });
  $('#charges').on('cocoon:before-remove', function(e, inserted_item) {
      inserted_item.children('input[type="number"]').val(0);
  });
  $('#charges').on('cocoon:after-remove', function(e, inserted_item) {
      update_sale_data();
  });
      
  }).call(this);
});

function add_change_listener(select_object,price_object){
    select_object.change(function(){ 
        $.ajax({
            url: '/items/' +select_object.val(),
            type: 'GET',
            dataType: 'json',
            success: function(data){
                price_object.val(data.price);
                update_sale_data();
            },
        });
    });
    price_object.change(function(){
        update_sale_data();
    });
}

function update_sale_data(){
    var q = $(".nested-fields").length;
    $("#sale_number_of_items").val(q);
    var sum = 0;
    $(".nested-fields > input[type='number']").each(function () {
            sum += parseInt($(this).val());
    });
    $("#sale_total_charge").val(sum);
    return 0;
}
