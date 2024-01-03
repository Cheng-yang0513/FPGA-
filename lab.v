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
