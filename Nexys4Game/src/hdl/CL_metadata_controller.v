module CL_metadata_controller(
    input clk, //100mhz clk
    input clk25, //25mhz clk
    input write_en, //signals a new word to be written
    input [31:0] write_word, //word to be written    
    
    output reg loaded
    
    );
    
    initial loaded = 0;
    
    
    //2^12 = 4096 words 
    mybram #(.LOGSIZE(12),.WIDTH(32)) //WORD:= 3 system bits (0b000 for note, 0b111 for end of data), 6'b for pitch, 3'b for string, 4'b for fret, 16'b for time
    memory(.addr(),.clk(clk),.we(),.din(),.dout());

    
    
    
endmodule