def factor_params(params)
  value = params['text'].split(params['trigger_word'])[1].delete(' ')
end
