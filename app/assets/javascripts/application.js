//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require select2
//= require sortable
//= require typeahead
//= require jquery.lazyload
//= require jquery.tagcloud

//= require jquery.ui.widget
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require tmpl

//= require jquery.throttle-debounce
//= require jquery.fluidbox

//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require_tree .

$(function(){

  if($("#searchBar").length > 0) {

    var collection = $('#searchBar').data('collection');

    var searchResult = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
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
      Turbolinks.visit('/' + collection + '/' + suggestion['_id']['$oid'], { cacheRequest: false })
    });
  }

  function setupImageEffect(){
    $("img.lazy").lazyload({
      effect : "fadeIn"
    });

    $('a.fullsizable').fluidbox();
  }

  if($('.upload-area').length > 0){

    var resource_id = $('.upload-area').data('id');
    var collection = $('.upload-area').data('collection');

    $('.upload-area').fileupload({
      dataType: 'json',
      url: '/' + collection + '/' + resource_id + '/batch_upload',
      dropZone: $('.upload-area'),
      singleFileUploads: false,

      add: function (e, data) {
        $(this).find('.icon').addClass('hidden');
        $(this).find('.progress').removeClass('hidden');

        data.submit();
      },

      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('.progress .progress-bar').css(
            'width',
            progress + '%'
        );
      },

      done: function(e, data){
        var $this = $(this);
        $this.find('.progress').addClass('hidden');
        console.log(data.result);
        $.each(data.result, function(index, image) {
          $this.find('.list').prepend(tmpl("tmplImg", image));
        });

        setupImageEffect();
      }
    });

    $(document).bind('dragover', function (e) {
      var dropZone = $('.upload-area'),
      timeout = window.dropZoneTimeout;
      if (!timeout) {
        dropZone.addClass('in');
      } else {
        clearTimeout(timeout);
      }
      var found = false,
      node = e.target;
      do {
        if (node === dropZone[0]) {
          found = true;
          break;
        }
        node = node.parentNode;
      } while (node != null);
      if (found) {
        dropZone.addClass('hover');
      } else {
        dropZone.removeClass('hover');
      }
      window.dropZoneTimeout = setTimeout(function () {
        window.dropZoneTimeout = null;
        dropZone.removeClass('in hover');
      }, 100);
    });
  }

  $.fn.tagcloud.defaults = {
    size: {start: 14, end: 50, unit: 'px'},
    color: {start: '#FFE23D', end: '#F43900'}
  };

  $(function () {
    $('#tagCloud a').tagcloud();
  });

  NProgress.configure({
    showSpinner: false,
    ease: 'ease',
    speed: 500
  });

  if($("#items").length > 0){

    var collection = $('#items').data('collection');

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

              Turbolinks.visit(window.location.href, { cacheRequest: false })

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
              Turbolinks.visit(window.location.href, { cacheRequest: false })
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
        if(evt.oldIndex != evt.newIndex){
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
      }
    });
  }

  $("#bq_package_tags, #album_tags").select2({
    tags: true
  })

  setupImageEffect();
})
