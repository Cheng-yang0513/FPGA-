 
![image](https://github.com/Cheng-yang0513/FPGA-/assets/68553170/d62c8e73-b3b3-41b8-82d3-2e7763ec5832)

藍色指撥開關：輸入密碼

紅色指撥開關：正確密碼

![image](https://github.com/Cheng-yang0513/FPGA-/assets/68553170/6ef7e5e5-93c0-497d-9a82-21eaf4402a1d)

D1:設定燈號

D2:正確或錯誤燈號

D3~D6:正確密碼的燈號

![image](https://github.com/Cheng-yang0513/FPGA-/assets/68553170/b66a2449-f551-4551-a97b-a561701f673d)

BEEP:蜂鳴器，答對會發出聲音

S1:設定鍵

S2:解鎖鍵

FPGA CODE
module	lab(
	input		[3:0] setting_password, 	//輸入設定密碼
	input		[3:0] try_password,			//輸入猜測密碼
	input		setting,							//設定密碼
	input		unlock,							//嘗試解鎖
	output	[3:0] password_out,			//目前密碼	
	output reg		unlock_out,				//解鎖燈號
	output reg		lock_out,				//上鎖燈號
	output reg		beep = 0					//蜂鳴器
);
	reg[3:0]password; 						//儲存密碼
	reg check; 									//輸入正確後輸入錯誤也不會鎖定
	
	assign password_out = password;

always @(setting,unlock)
	begin
		if(setting)
			begin
				password = ~setting_password;
				lock_out = 1;
				unlock_out = 0;
				check = 0;  					//上鎖狀態
				beep = 0;
			end
		else if(unlock)
			begin	
				if(try_password == password && check==0)//輸入正確
					begin
						lock_out = 0;
						unlock_out = 1;
						check = 1;     		//解鎖狀態
						beep = 1;
					end
				
				else if(try_password != password && check==0)//輸入錯誤
					begin
						lock_out = 1;
						unlock_out = 0;
						check = 0;
						beep = 0; 				//蜂鳴器響
					end
					
			end
		
		
	end
	
endmodule

