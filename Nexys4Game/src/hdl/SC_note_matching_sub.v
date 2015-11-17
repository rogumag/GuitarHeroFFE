module SC_note_matching_sub(
    input clk,
    input song_time, //current song time
    input note_edge, //if note has become active (must be a single-cycle pulse)
    input [17:0] note_time, //time of next note, or all 1's if no note in buffer
    output reg note_request, //a pulse if a new note is needed to be shifted in    
    output reg match_enable, //a pulse signaling a new note-match
    output reg [17:0] match_time //time which the note has been matched to.
    );
    
    reg [17:0] past_note, future_note; //time of closest nearby note
    localparam NOTE_TIMEOUT = 100; //time it takes for a note to no longer be considered, in 10ms (100 = 1s) 
    
    
    
    always @(posedge clk) begin
        
        if(future_note < song_time) begin
            past_note <= future_note;
        end
        
        if(song_time - past_note > NOTE_TIMEOUT) begin //if nearest note is timed-out MAY CONTAIN SIGN PROBLEMS
            past_note <= 0; //write invalid
        end
        
        if(note_edge) begin
            if( song_time - past_note < future_note - song_time) begin //match to past note. Note that if past_note is written invalid, this test will fail with extremely high probability
                match_enable <= 1'b1;
                match_time <= past_note
                past_note <= 0;
            end
            else begin //match to future note
                match_enable <= 1'b1;
                match_time <= future_note;
            end
        end
        else if(match_enable) begin //reset match_enable
            match_enable <= 0
        end
        
    end 
    
    
endmodule