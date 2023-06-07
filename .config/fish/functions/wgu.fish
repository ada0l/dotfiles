function wgu --wraps='wg-quick up wg1' --description 'alias wgu=wg-quick up wg1'
  wg-quick up wg1 $argv
        
end
