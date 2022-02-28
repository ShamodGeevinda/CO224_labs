/*
Module  : Data Cache 
Author  : Isuru Nawinne, Kisaru Liyanage
Date    : 25/05/2020

Description	:

This file presents a skeleton implementation of the cache controller using a Finite State Machine model. Note that this code is not complete.
*/

`timescale 1ns/100ps

module dcache (clock,
    reset,
    read,
    write,
    address,
    writedata,
    readdata,
    busywait,

    mem_read,
    mem_write,
    mem_busywait,
    mem_writedata,
    mem_readdata,
    mem_address
    );

    input           clock;
    input           reset;
    input           read;
    input           write;
    input[7:0]      address;
    input[7:0]      writedata;
    output reg [7:0]readdata;
    output reg      busywait;

    output reg          mem_read;
    output reg          mem_write;
    input               mem_busywait;
    output reg [31:0]   mem_writedata;
    input[31:0]         mem_readdata;
    output reg [5:0]    mem_address;



    // registers for interenal implementations
    reg [2:0] index,tag;
	reg [1:0] offset;
    reg hit, dirty;

    
    

    // Cache arrays
    reg [31:0] cache_block [7:0];
	reg [2:0] tag_array [7:0];
	reg valid_array [7:0];
	reg dirty_array [7:0];

    // generating busywait signals
    always @(read, write)
	begin
		 if (read || write) busywait = 1 ;
         else busywait = 0;
	end

    //Combinational part for indexing, tag comparison for hit deciding, etc.
    always @(address,read ,write)
    begin
    
        // extract tag, index and offset from input address
        #1 {tag,index,offset} = address;

        if (read || write)
        begin
            // dirty bit val
            dirty = dirty_array[index] ;

            // tag comparison 
            #0.9 hit = (tag_array[index] == tag ) && valid_array[index] ;
        end
    end
	

    // reading values in cache
	always @(*)
	begin
	if(read && hit)begin
		case(offset)
			'b00:	
                #1 readdata = cache_block[index][7:0];
			'b01:	
                #1 readdata = cache_block[index][15:8];
			'b10:	
                #1 readdata = cache_block[index][23:16];
			'b11:	
                #1 readdata = cache_block[index][31:24];
		endcase
	end
	end


    // when it's a hit no need to stall cpu. therfore busywait = 0;
    always @(posedge clock) begin
        if (hit) busywait = 0;
    end


    // writing to cache memory @ positive edge of the clock
    always @ (posedge clock)
    begin
    
        if (write && hit == 1 && mem_busywait != 1)
        begin
            case (offset)
                2'b00 : 
                    #1 cache_block[index][7:0] = writedata ;
                2'b01 : 
                    #1 cache_block[index][15:8] = writedata ;
                2'b10 : 
                    #1 cache_block[index][23:16] = writedata ;
                2'b11 : 
                    #1 cache_block[index][31:24]  = writedata ; 
            endcase
            // making coressponding dirty bit to zero
            dirty_array[index]= 1; 
        end
    end
   

    

    /* Cache Controller FSM Start */

    parameter IDLE = 3'b000, MEM_READ = 3'b001, MEM_WRITE = 3'b010;
    reg [2:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if ((read || write) && !dirty && !hit)  
                    next_state = MEM_READ;
                else if ((read || write) && dirty && !hit)
                    next_state = MEM_WRITE;
                else
                    next_state = IDLE;
            
            MEM_READ:
                if (!mem_busywait)
                    next_state = IDLE;
                else    
                    next_state = MEM_READ;

            MEM_WRITE:
                if (!mem_busywait)
                    next_state = MEM_READ;
                else    
                    next_state = MEM_WRITE;
            
        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)
            IDLE:
            begin
                mem_read = 0;
                mem_write = 0;
                mem_address = 8'dx;
                mem_writedata = 8'dx;
                busywait = 0;
            end
         
            MEM_READ: 
            begin
                mem_read = 1;
                mem_write = 0;
                mem_address = {tag, index};
                mem_writedata = 32'dx;
                busywait = 1;
            end

            MEM_WRITE: 
            begin
                mem_read = 0;
                mem_write = 1;
                mem_address = {tag, index};
                mem_writedata = cache_block[index];
                busywait = 1;
            end
            
        endcase
    end

    // sequential logic for state transitioning 
    always @(posedge clock, reset)
    begin
        if(reset)
            state = IDLE;
        else
            state = next_state;
    end

    /* Cache Controller FSM End */

endmodule