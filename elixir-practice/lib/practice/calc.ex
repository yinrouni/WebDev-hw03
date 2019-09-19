defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    #convertHelp(String.split(expr,~r/\s+/), [], [])|> hd |> parse_float
    evaluate(convertHelp(String.split(expr, ~r/\s+/), [], []), [])
    #|> String.split(~r/\s+/)|> (fn(s) -> convertHelp(ls, [], []) end)
    #|> hd
    #|> parse_float
    #|> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
 
  def evaluate([ls_hd|ls_tl], answer) do
     if (!isOperator(ls_hd)) do 
         evaluate(ls_tl, [parse_float(ls_hd)] ++ answer)
     else
        op_a = hd(answer)
        op_b = hd(tl(answer))
        rest = tl(tl(answer))    

        cond do 
            ls_hd == "+" -> evaluate(ls_tl, [op_b + op_a | rest])
            ls_hd == "-" -> evaluate(ls_tl, [op_b - op_a | rest])
            ls_hd == "*" -> evaluate(ls_tl, [op_b * op_a | rest])
            ls_hd == "/" -> evaluate(ls_tl, [op_b / op_a | rest])
        end
     end        
  end
  def evaluate([], answer) do 
     hd(answer)
  end 

  def convertHelp([expr_hd|expr_tl], ret, help) do
      if (!isOperator(expr_hd)) do
         convertHelp(expr_tl, ret ++ [expr_hd], help)
      else
      if (length(help)== 0 || operator_prec(hd(help)) < operator_prec(expr_hd)) do
	     convertHelp(expr_tl, ret, [expr_hd|help])
	 else 
             convertHelp([expr_hd|expr_tl], ret ++ [hd(help)], tl(help))
         end
      end 
          
  end
  def convertHelp([], ret, help) do 
     if (length(help) == 0) do
          ret
     else 
         convertHelp([], ret ++ [hd(help)], tl(help))
     end 


  end 

  def isOperator(tok)do 
    if(tok == "+" || tok == "-" || tok == "*" || tok == "/") do 
       true
    else 
       false
    end
  end

 def operator_prec(tok) do
    cond do
      tok == "+" -> 1
      tok == "-" -> 1
      tok == "*" -> 2
      tok == "/" -> 2
      true -> 0
    end
  end 
   
  def getElement(tok) do
      if (isOperator(tok)) do
           tok
      else
         parse_float(tok)
    end
  end

  def tag_tokens(list) do
    Enum.map(list, &getElement/1)
  end

end
