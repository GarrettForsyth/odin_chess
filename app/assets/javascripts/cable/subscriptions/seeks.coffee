App.seeks = App.cable.subscriptions.create 'SeeksChannel',
  received: (data) ->
    if data.action && !data.action.blank?
      switch data.action
        when 'add'
          $('#seek-table').append(data.seek)
        
        when 'destroy'
          console.log('test destroy')
          $("#seek_#{data.seek_id}").remove()
