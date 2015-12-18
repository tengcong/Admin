//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require select2
//= require sortable
//= require typeahead
//= require_tree .

$(function(){

  if($("#items").length > 0){

    var collection = $('#items').data('collection');

    var searchResult = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,

      //prefetch: '../data/films/post_1960.json',
      remote: {
        url: '/' + collection + '/search?q=%QUERY',
        wildcard: '%QUERY'
      }
    });

    $('#searchBar .typeahead').typeahead(null, {
      name: 'search-result',
      display: function(data){
        value = data['name'] || data['title']
        return value;
      },
      source: searchResult
    });

    $('#searchBar .typeahead').bind('typeahead:select', function(ev, suggestion) {
      window.location.href = '/' + collection + '/' + suggestion['_id']['$oid'];
    });

    $(".batch-move").click(function(e){
      e.preventDefault();

      if(confirm('确定移到顶部？')){

        var ids = $('#items input[type=checkbox]:checked');

        var arr = [];
        ids.map(function(i, e){
          arr.push($(e).val());
        });

        $.ajax({
          url: '/' + collection + '/batch_move',
          method: 'patch',
          data: { ids: arr, direction: $(this).data('direction') },
          success: function(data){
            if(data.success){
              window.location.reload();
            }else{
              console.log(data);
            }
          }
        });

      }
    });

    $("#batch_destroy").click(function(e){
      e.preventDefault();

      if(confirm('确定删除？')){
        var ids = $('#items input[type=checkbox]:checked');

        var arr = [];
        ids.map(function(i, e){
          arr.push($(e).val());
        });

        $.ajax({
          url: '/' + collection + '/batch_destroy',
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

        $.post('/' + collection + '/' + id + '/move_to', { to: to }, function(data){
          if(data.data){
            console.log('done');
          }else{
            alert('卧槽出错了');
          }
        })
      }
    });
  }

  $("#bq_package_tags, #album_tags").select2({
    tags: true
  })
})
