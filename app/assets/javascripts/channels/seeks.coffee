App.seeks = App.cable.subscriptions.create 'SeeksChannel',
  received: (data) ->
    if data.add_seek && !data.add_seek.blank?
      $('#seek-table').append(data.add_seek)

    if data.destroy_seek && !data.destroy_seek.blank?
      $("#seek_#{data.destroy_seek}").remove()
