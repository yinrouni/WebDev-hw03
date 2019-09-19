defmodule Practice.Factor do

  def factor(text) do
        x = parse(text)
	if (x==1) do
		[]
        end
	ls = factor_two([], x)
        y=no_two(x)
        if (y==1)do
            ls
        else
	    factor_more(ls, y, 3)
        end    
	
  end
  def parse(text)do
	if (is_integer(text)) do
  		text
        else
		String.to_integer(text)
        end
  end

  def factor_two(ls, x) do
    if (rem(x, 2)== 0) do
      factor_two(ls ++ [2], div(x,2))
    else 
      ls
    end
  end
  def no_two(x)do
    if (rem(x, 2)== 0)do
      no_two(div(x, 2))
    else
      x
    end
  end
  def factor_more(ls,x, f)do
    if (f == x) do
       ls ++ [f]
    else
    if (rem(x, f)==0) do
      factor_more(ls ++[f], div(x, f), f)
    else 
      factor_more(ls, x, f+2)
    end
   end


  end
end
 
