App.seeks = App.cable.subscriptions.create 'SeeksChannel',
  received: (data) ->
    if data.seek && !data.seek.blank?
      $('#seek-table').append(data.seek)
