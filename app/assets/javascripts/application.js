//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require select2
//= require sortable
//= require_tree .

$(function(){

  $("#batch_destroy").click(function(e){
    e.preventDefault();

    if(confirm('确定删除？')){
      var ids = $('#items input[type=checkbox]:checked');

      var arr = [];
      ids.map(function(i, e){
        arr.push($(e).val());
      });

      $.ajax({
        url: 'bq_packages/batch_destroy',
        method: 'delete',
        data: { ids: arr },
        success: function(data){
          if(data.success){
            window.location.reload();
          }else{
            console.log(data);
          }
        }
      });
    }
  })

  $("#bq_package_tags").select2({
    tags: true
  })

  var el = document.getElementById('items');

  var sortable = Sortable.create(el, {

    dragable: ".item",
    ghostClass: 'sortable-ghost',
    chosenClass: 'sortable-chosen',
    dataIdAttr: 'data-position',
    handle: '.my-handle',

    onEnd: function(evt){

      var $item = $(evt.item);
      var from, to;
      var id = $item.data('id');
      if(evt.oldIndex < evt.newIndex){
        from = $item.data('position')
        to = $item.prev().data('position')
      }else{
        from = $item.data('position')
        to = $item.next().data('position')
      }

      $.post('/bq_packages/' + id + '/move_to', { to: to }, function(data){
        if(data.data){
          console.log('done');
        }else{
          alert('卧槽出错了');
        }
      })
    }

  });
})
