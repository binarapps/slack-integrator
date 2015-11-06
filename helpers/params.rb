def factor_params(params)
  trigger = params['trigger_word'] + ' '
  params['text'].split(trigger)[1]
end
