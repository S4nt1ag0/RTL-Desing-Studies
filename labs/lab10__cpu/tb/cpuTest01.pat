/******************************************************************************
* Test program 1 for the Risc CPU system.
*
*
* This diagnostic program tests the basic instruction set of the Risc
* system.  If the system executes each instruction correctly, then it should
* halt when the HLT instruction at address 17(hex) is executed.
*
* If the system halts at any other location, then an instruction did not
* execute properly.  Refer to the comments in this file to see which
* instruction failed.
*****************************************************************************/
 
//opcode_operand  // addr                   assembly code
//--------------  // ----  -----------------------------------------------
@00 111_11110     //  00   BEGIN:   JMP TST_JMP
    000_00000     //  01            HLT        //JMP did not work at all
    000_00000     //  02            HLT        //JMP did not load PC, it skipped
    101_11010     //  03   JMP_OK:  LDA DATA_1
    001_00000     //  04            SKZ
    000_00000     //  05            HLT        //SKZ or LDA did not work
    101_11011     //  06            LDA DATA_2
    001_00000     //  07            SKZ
    111_01010     //  08            JMP SKZ_OK
    000_00000     //  09            HLT        //SKZ or LDA did not work
    110_11100     //  0A   SKZ_OK:  STO TEMP   //store non-zero value in TEMP
    101_11010     //  0B            LDA DATA_1
    110_11100     //  0C            STO TEMP   //store zero value in TEMP
    101_11100     //  0D            LDA TEMP
    001_00000     //  0E            SKZ        //check to see if STO worked
    000_00000     //  0F            HLT        //STO did not work
    100_11011     //  10            XOR DATA_2
    001_00000     //  11            SKZ        //check to see if XOR worked
    111_10100     //  12            JMP XOR_OK
    000_00000     //  13            HLT        //XOR did not work at all
    100_11011     //  14   XOR_OK:  XOR DATA_2
    001_00000     //  15            SKZ
    000_00000     //  16            HLT        //XOR did not switch all bits
    000_00000     //  17   END:     HLT        //CONGRATULATIONS - TEST1 PASSED!
    111_00000     //  18            JMP BEGIN  //run test again
 
@1A 00000000      //  1A   DATA_1:             //constant 00(hex)
    11111111      //  1B   DATA_2:             //constant FF(hex)
    10101010      //  1C   TEMP:               //variable - starts with AA(hex)
 
@1E 111_00011     //  1E   TST_JMP: JMP JMP_OK
    000_00000     //  1F            HLT        //JMP is broken