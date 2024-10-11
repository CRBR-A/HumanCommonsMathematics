# script: genFiles.sh
# goal: write files for arithmetic operations
# author: cerbere.ace (cerbere.ace@gmail.com)
# licence: Unlicense

#Variables
startingNumbers=(-1 0)
operations=("+" "-" "*" "/")
opNames=("add" "subtract" "multiply" "divide")
cellSize=3

#Loop all operations
for((currentOp=0;currentOp<${#operations[@]};currentOp++));do
  #Loop starting numbers
  for startingNumber in "${startingNumbers[@]}"; do
    
    #Variables
    startingRowNumber=$((startingNumber))
    endingRowNumber=$((101+startingNumber))
    
    if [[ ! -d "${opNames[$currentOp]}" ]]; then
      mkdir -p "${opNames[$currentOp]}"
    fi
    
    file="${opNames[$currentOp]}/grid-${opNames[$currentOp]}-${startingRowNumber}-${endingRowNumber}.txt"
    
    #Init row
    row=$((startingRowNumber))
    
    #Loop until row finished
    while ((row!=endingRowNumber)); do
      linePrinted=""
      subLinePrinted=""
      
      #For each col
      for((col=startingNumber;col<11+startingNumber;col++));do

        if ((row==startingRowNumber && col==startingNumber)); then
          value=""
        elif ((row==startingRowNumber)); then
          #The header : print the sign + value
          value="${operations[$currentOp]}${col}"
        elif ((col==startingNumber)); then
          value="${row}"
        else
          if [[ "${operations[$currentOp]}" == "+" ]]; then
            value=$((col+row))
          elif [[ "${operations[$currentOp]}" == "*" ]]; then
            value=$((col*row))
          elif [[ "${operations[$currentOp]}" == "-" ]]; then
            value=$((row-col))
          elif [[ "${operations[$currentOp]}" == "/" ]]; then
            if((col==0)); then
              value="err"
            elif (( row%col==0)); then
              value=$((row/col))
            else 
              value=""
            fi
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
      
      #add the first line
      if ((row==startingRowNumber)); then
        echo "${subLinePrinted}" > "${file}"
      fi
      
      #print the line
      echo "${linePrinted}" >> "${file}"
      
      #print a header or normal separator
      if ((row==startingRowNumber)); then
        echo "${subLinePrinted//-/=}" >> "${file}"
      else
        echo "${subLinePrinted}" >> "${file}"
      fi
      
      #Increment OR decrement the row
      if (( startingRowNumber<endingRowNumber)); then
        row=$((row+1))
      else
        row=$((row-1))
      fi
    done
  done
done
