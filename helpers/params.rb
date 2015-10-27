def factor_params(params)
  trigger = params['trigger_word'] + ' '
  value = params['text'].split(trigger)[1]
end
