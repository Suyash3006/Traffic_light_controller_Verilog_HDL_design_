`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2022 14:56:08
// Design Name: 
// Module Name: Traffic_light_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2022 12:47:45
// Design Name: 
// Module Name: traffic_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_control(n_g, n_y, n_r,s_g, s_y, s_r, e_g, e_y, e_r, w_g, w_y, w_r, clk,rst_a,co);

   output reg n_g, n_y, n_r,s_g, s_y, s_r, e_g, e_y, e_r, w_g, w_y, w_r; 
   input      clk;
   input      rst_a;
   output co;
 
   reg [2:0] state;
 
   parameter [2:0] north=3'b000;
   parameter [2:0] north_y=3'b001;
   parameter [2:0] south=3'b010;
   parameter [2:0] south_y=3'b011;
   parameter [2:0] east=3'b100;
   parameter [2:0] east_y=3'b101;
   parameter [2:0] west=3'b110;
   parameter [2:0] west_y=3'b111;

   reg [2:0] count;
   reg [27:0]cnt=0;
   
   assign co= cnt[27];
   always@(posedge clk)
    begin
        cnt<= cnt + 1;
    end
        
 

   always @(posedge co, posedge rst_a)
     begin
        if (rst_a)
            begin
                state=north;
                count =3'b000;
            end
        else
            begin
                case (state)
                north :
                    begin
                        if (count==3'b111)
                            begin
                            count=3'b000;
                            state=north_y;
                            end
                        else
                            begin
                            count=count+3'b001;
                            state=north;
                            end
                    end

                north_y :
                    begin
                        if (count==3'b011)
                            begin
                            count=3'b000;
                            state=south;
                            end
                        else
                            begin
                            count=count+3'b001;
                            state=north_y;
                        end
                    end

               south :
                    begin
                        if (count==3'b111)
                            begin
                            count=3'b0;
                            state=south_y;
                            end
                        else
                            begin
                            count=count+3'b001;
                            state=south;
                        end
                    end

            south_y :
                begin
                    if (count==3'b011)
                        begin
                        count=3'b0;
                        state=east;
                        end
                    else
                        begin
                        count=count+3'b001;
                        state=south_y;
                        end
                    end

            east :
                begin
                    if (count==3'b111)
                        begin
                        count=3'b0;
                        state=east_y;
                        end
                    else
                        begin
                        count=count+3'b001;
                        state=east;
                        end
                    end

            east_y :
                begin
                    if (count==3'b011)
                        begin
                        count=3'b0;
                        state=west;
                        end
                    else
                        begin
                        count=count+3'b001;
                        state=east_y;
                        end
                    end

            west :
                begin
                    if (count==3'b111)
                        begin
                        state=west_y;
                        count=3'b0;
                        end
                    else
                        begin
                        count=count+3'b001;
                        state=west;
                        end
                    end

            west_y :
                begin
                    if (count==3'b011)
                        begin
                        state=north;
                        count=3'b0;
                        end
                    else
                        begin
                        count=count+3'b001;
                        state=west_y;
                        end
                    end
            endcase // case (state)
        end // always @ (state)
    end 


always @(state)
     begin
         case (state)
            north :
                begin
                    n_g = 1;
                    n_y = 0;
                    n_r = 0;
                    s_g = 0;
                    s_y = 0;
                    s_r = 1;
                    w_g = 0;
                    w_y = 0;
                    w_r = 1;
                    e_g = 0;
                    e_y = 0;
                    e_r = 1;
                end // case: north

            north_y :
                begin
                    n_g = 0;
                    n_y = 1;
                    n_r = 0;
                    s_g = 0;
                    s_y = 0;
                    s_r = 1;
                    w_g = 0;
                    w_y = 0;
                    w_r = 1;
                    e_g = 0;
                    e_y = 0;
                    e_r = 1;
                end // case: north_y

            south :
                begin
                    n_g = 0;
                    n_y = 0;
                    n_r = 1;
                    s_g = 1;
                    s_y = 0;
                    s_r = 0;
                    w_g = 0;
                    w_y = 0;
                    w_r = 1;
                    e_g = 0;
                    e_y = 0;
                    e_r = 1;
                end // case: south

            south_y :
                begin
                    n_g = 0;
                    n_y = 0;
                    n_r = 1;
                    s_g = 0;
                    s_y = 1;
                    s_r = 0;
                    w_g = 0;
                    w_y = 0;
                    w_r = 1;
                    e_g = 0;
                    e_y = 0;
                    e_r = 1;
                end // case: south_y

            west :
                begin
                    n_g = 0;
                    n_y = 0;
                    n_r = 1;
                    s_g = 0;
                    s_y = 0;
                    s_r = 1;
                    w_g = 1;
                    w_y = 0;
                    w_r = 0;
                    e_g = 0;
                    e_y = 0;
                    e_r = 1;
                end // case: west

            west_y :
                begin
                    n_g = 0;
                    n_y = 0;
                    n_r = 1;
                    s_g = 0;
                    s_y = 0;
                    s_r = 1;
                    w_g = 0;
                    w_y = 1;
                    w_r = 0;
                    e_g = 0;
                    e_y = 0;
                    e_r = 1;
                end // case: west_y

            east :
                begin
                    n_g = 0;
                    n_y = 0;
                    n_r = 1;
                    s_g = 0;
                    s_y = 0;
                    s_r = 1;
                    w_g = 0;
                    w_y = 0;
                    w_r = 1;
                    e_g = 1;
                    e_y = 0;
                    e_r = 0;
                end // case: east

            east_y :
                begin
                    n_g = 0;
                    n_y = 0;
                    n_r = 1;
                    s_g = 0;
                    s_y = 0;
                    s_r = 1;
                    w_g = 0;
                    w_y = 0;
                    w_r = 1;
                    e_g = 0;
                    e_y = 1;
                    e_r = 0;
                end // case: east_y
            endcase // case (state)
     end // always @ (state)
endmodule
