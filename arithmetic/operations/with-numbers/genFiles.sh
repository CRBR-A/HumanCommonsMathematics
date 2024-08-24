
operations=("+" "*")
cellsSize=("2" "3")


for((currentOp=0;currentOp<${#operations[@]};currentOp++));do
  
  file="Op${currentOp}.txt"
  cellSize="${cellsSize[$currentOp]}"
  
  for((row=0; row<11; row++)); do
    linePrinted=""
    subLinePrinted=""
    
    for((col=0;col<21;col++));do

      if ((row==0 && col==0)); then
        value="${operations[$currentOp]}"
      elif ((row==0)); then
        value="${col}"
      elif ((col==0)); then
        value="${row}"
      else
        if [[ "${operations[$currentOp]}" == "+" ]]; then
          value=$((col+row))
        elif [[ "${operations[$currentOp]}" == "*" ]]; then
          value=$((col*row))
        fi
      fi
      
      #Add a space with the result is smaller than cell size
      while ((${#value}<cellSize)); do
        value=" ${value}"
      done
      #Add the result to the current cell
      linePrinted="${linePrinted}|${value}"
      
      #Create a cell separator
      value="-"
      while ((${#value}<cellSize)); do
        value="-${value}"
      done
      #Add the cell separator to the cell line
      subLinePrinted="${subLinePrinted}+${value}"
        
    done
    
    #End the lines
    linePrinted="${linePrinted}|"
    subLinePrinted="${subLinePrinted}+"
    
    if ((row==0)); then
      echo "${subLinePrinted}" > "${file}"
    fi
    
    #print the lines
    echo "${linePrinted}" >> "${file}"
    echo "${subLinePrinted}" >> "${file}"
    
  done
done
