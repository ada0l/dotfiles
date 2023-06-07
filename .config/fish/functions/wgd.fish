function wgd --wraps='wg-quick up wg1' --description 'alias wgd=wg-quick up wg1'
  wg-quick up wg1 $argv
        
end
